#!/usr/bin/env ruby

require 'open3'
require 'net/http'

while (index = ARGV.index('-I'))
  _,path = ARGV.slice!(index, 2)
  $: << path
end

$bench_duration = '2'
$rate_con_count = '100'
$lat_con_count = '5'
$results = {}

# returns [rate, latency]
def bench_path(path, port, keep_alive)
  rate = 0
  latency = 0
  cmd = ['perfer', '-p', path, '-t', '2', '-b', '4', '-c', $rate_con_count, '-d', $bench_duration, "127.0.0.1:#{port}"]
  cmd << '-k' if keep_alive
  # Run with more threads and more connections to get the max throughput. If
  # the rate count is 100 and threads is 4 then 400 keep-alive connections are
  # in use. The intent to to see how the server handles higher loads.
  Open3.popen3(*cmd) { |_, out, err, pwt|
    s = out.read
    #puts s
    target = 'for a rate of '
    i = s.index(target) + target.size
    j = s.index(' ', i) -1
    rate = s[i..j].to_i
  }
  # Run with a small number of connections to get the best latency.
  cmd = ['perfer', '-p', path, '-t', '2', '-b', '1', '-c', $lat_con_count, '-d', $bench_duration, "127.0.0.1:#{port}"]
  cmd << '-k' if keep_alive
  Open3.popen3(*cmd) { |_, out, err, pwt|
    s = out.read
    #puts s
    target = 'average latency of '
    i = s.index(target) + target.size
    j = s.index(' ', i) -1
    latency = s[i..j].to_f
  }
  [rate, latency]
end

def wait_up(port)
  uri = URI("http://localhost:#{port}/hello")
  # keep trying until 10 resonses are received. That verifies the server has
  # started and warms it up.
  cnt = 0
  100.times {
    begin
      Net::HTTP.get(uri)
      cnt += 1
      break if 10 < cnt
    rescue Exception
      sleep(0.05)
    end
  }
end

def bench_gem(gem, version, port, keep_alive=true)
  result = { version: version }

  rate, latency = bench_path('/index.html', port, keep_alive)
  result[:static_rate] = rate
  result[:static_latency] = latency
  puts "%-9s static: %7d requests/sec % 7.2f milliseconds/request" % [gem, rate, latency]

  rate, latency = bench_path('/hello', port, keep_alive)
  result[:rack_rate] = rate
  result[:rack_latency] = latency
  puts "%-9s   rack: %7d requests/sec % 7.2f milliseconds/request" % [gem, rate, latency]

  result
end

# Agoo benchmarks
begin
  require 'agoo'
  _, _, _, wt = Open3.popen3('ruby', 'agoo_bench.rb')
  wait_up(6460)
  $results['Agoo'] = bench_gem('Agoo', Agoo::VERSION, 6460)
  Process.kill('INT', wt.pid)
rescue LoadError
rescue Exception => e
  puts "** Agoo - #{e.class}: #{e.message}"
end

# Goliath benchmarks
=begin
  require 'goliath'
  _, _, _, wt = Open3.popen3('ruby', 'goliath_bench.rb', '-p', '6461')
  wait_up(6461)
  $results['Goliath'] = bench_gem('Goliath', Goliath::VERSION, 6461)
  Process.kill('INT', wt.pid)
rescue LoadError
rescue Exception => e
  puts "** Goliath - #{e.class}: #{e.message}"
=end

# http-2 is not a rack web server so it is not included in the benchmarks.

# Iodine benchmarks
begin
  require 'iodine'
  _, _, _, wt = Open3.popen3('iodine', '-p', '6463', 'iodine_bench.ru')
  wait_up(6463)
  $results['Iodine'] = bench_gem('Iodine', Iodine::VERSION, 6463)
  Process.kill('INT', wt.pid)
rescue LoadError
rescue Exception => e
  puts "** Iodine - #{e.class}: #{e.message}"
end

# Passenger benchmarks
begin
  require 'phusion_passenger'
  _, _, _, wt = Open3.popen3('passenger', 'start', '-p', '6464', '-R', 'passenger_bench.ru')
  wait_up(6464)
  $results['Passenger'] = bench_gem('Passenger', 'latest', 6464)
  Process.kill('INT', wt.pid)
rescue LoadError
rescue Exception => e
  puts "** Passenger - #{e.class}: #{e.message}"
end

# Puma benchmarks
begin
  require 'puma'
  _, _, _, wt = Open3.popen3('rackup', 'puma_bench.ru')
  wait_up(6465)
  $results['Puma'] = bench_gem('Puma', 'latest', 6465)
  Process.kill('INT', wt.pid)
rescue LoadError
rescue Exception => e
  puts "** Puma - #{e.class}: #{e.message}"
end

# Reel benchmarks - was not able to get the command to work.
=begin
  require 'reel'
  _, _, _, wt = Open3.popen3('reel-rack', '-p', '6466', 'reel_bench.ru')
  wait_up(6466)
  $results['Reel'] = bench_gem('Reel', Reel::VERSION, 6466)
  Process.kill('INT', wt.pid)
rescue LoadError
rescue Exception => e
  puts "** Rell - #{e.class}: #{e.message}"
=end

# Thin benchmarks
begin
  require 'thin'
  _, _, _, wt = Open3.popen3('ruby', 'thin_bench.rb')
  wait_up(6467)
  $results['Thin'] = bench_gem('Thin', Thin::VERSION::STRING, 6467, false)
  Process.kill('INT', wt.pid)
rescue LoadError
rescue Exception => e
  puts "** Thin - #{e.class}: #{e.message}"
end

# Unicorn benchmarks
=begin
  require 'unicorn'
  _, _, _, wt = Open3.popen3('unicorn', '-p', '6468', 'unicorn_bench.ru')
  wait_up(6468)
  $results['Unicorn'] = bench_gem('Unicorn', 'latest', 6468, false)
  Process.kill('INT', wt.pid)
rescue LoadError
rescue Exception => e
  puts "** Unicorn - #{e.class}: #{e.message}"
  e.backtrace.each {|line| puts line }
=end

# WEBrick benchmarks - More than one connection returns corrupt results.
=begin
  require 'webrick'
  _, _, _, wt = Open3.popen3('rackup', 'webrick_bench.ru')
  wait_up(6469)
  # WEBrick hangs or stalls when more than one connection is attempted.
  $results['WEBrick'] = bench_gem('WEBrick', WEBrick::VERSION, 6469, false)
  Process.kill('INT', wt.pid)
rescue LoadError
rescue Exception => e
  puts "** WEBrick - #{e.class}: #{e.message}"
=end

# Sort the results and display.
keys = []
$results.each { |gem,result|
  keys << [gem, result[:rack_rate]]
}
keys.sort! { |x1,x2|
  x2[1] <=> x1[1]
}

puts
puts "|           |    Rack Request    |   Static Request   |         |"
puts "|           |    rate |  latency |    rate |  latency |         |"
puts "| gem       | req/sec | msec/req | req/sec | msec/req | Version |"
puts "|:--------- | -------:| --------:| -------:| --------:| ------- |"
keys.each { |kr|
  result = $results[kr[0]]
  puts "| %-9s | % 7d | % 8.2f | % 7d | % 8.2f | %-7s |" % [kr[0], result[:rack_rate], result[:rack_latency], result[:static_rate], result[:static_latency], result[:version]]
}
puts
