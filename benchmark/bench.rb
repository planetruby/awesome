#!/usr/bin/env ruby

require 'open3'

require 'agoo'
require 'iodine'
require 'thin'
require 'webrick'

while (index = ARGV.index('-I'))
  _,path = ARGV.slice!(index, 2)
  $: << path
end

$server_wait_time = 1.0
$bench_duration = '2'
$rate_con_count = '100'
$lat_con_count = '5'
$results = {}

sleep $server_wait_time

# returns [rate, latency]
def bench_path(path, port, keep_alive)
  rate = 0
  latency = 0
  cmd = ['perfer', '-p', path, '-t', '4', '-c', $rate_con_count, '-d', $bench_duration, "127.0.0.1:#{port}"]
  cmd << '-k' if keep_alive
  # Run with more threads and more connections to get the max throughput. If
  # the rate count is 100 and threads is 4 then 400 keep-alive connections are
  # in use. The intent to to see how the server handles higher loads.
  Open3.popen3(*cmd) { |_, out, err, pwt|
    s = out.read

    target = 'for a rate of '
    i = s.index(target) + target.size
    j = s.index(' ', i) -1
    rate = s[i..j].to_i
  }
  # Run with a small number of connections to get the best latency.
  cmd = ['perfer', '-p', path, '-t', '2', '-c', $lat_con_count, '-d', $bench_duration, "127.0.0.1:#{port}"]
  cmd << '-k' if keep_alive
  Open3.popen3(*cmd) { |_, out, err, pwt|
    s = out.read

    target = 'average latency of '
    i = s.index(target) + target.size
    j = s.index(' ', i) -1
    latency = s[i..j].to_f
  }
  [rate, latency]
end

def bench_gem(gem, version, port, keep_alive=true)
  result = { version: version }
  # warm up
  Open3.popen3('perfer', '-p', '/hello', '-t', '1', '-c', '1', '-d', '1', "127.0.0.1:#{port}") { |_, out, err, pwt|
  }
  rate, latency = bench_path('/hello', port, keep_alive)
  result[:rack_rate] = rate
  result[:rack_latency] = latency
  puts "%-9s   rack: %7d requests/sec % 7.2f milliseconds/request" % [gem, rate, latency]
  
  rate, latency = bench_path('/index.html', port, keep_alive)
  result[:static_rate] = rate
  result[:static_latency] = latency
  puts "%-9s static: %7d requests/sec % 7.2f milliseconds/request" % [gem, rate, latency]

  result
end

# Agoo benchmarks
_, _, _, wt = Open3.popen3('ruby', '-I', '.', 'agoo_bench.rb')
sleep $server_wait_time
$results['Agoo'] = bench_gem('Agoo', Agoo::VERSION, 6460)
Process.kill('INT', wt.pid)

# Iodine benchmarks
_, _, _, wt = Open3.popen3('iodine', '-p', '6461', 'iodine_bench.ru')
sleep $server_wait_time
$results['Iodine'] = bench_gem('Iodine', Iodine::VERSION, 6461)
Process.kill('INT', wt.pid)

# Thin benchmarks
_, _, _, wt = Open3.popen3('ruby', 'thin_bench.rb')
sleep $server_wait_time
$results['Thin'] = bench_gem('Thin', Thin::VERSION::STRING, 6462, false)
Process.kill('INT', wt.pid)

# Puma benchmarks
_, _, _, wt = Open3.popen3('rackup', 'puma_bench.ru')
sleep $server_wait_time
$results['Puma'] = bench_gem('Puma', '??', 6466)
Process.kill('INT', wt.pid)

=begin
# WEBrick benchmarks - More than one connection returns corrupt results.
_, _, _, wt = Open3.popen3('rackup', 'webrick_bench.ru')
sleep $server_wait_time
# WEBrick hangs or stalls when more than one connection is attempted.
$results['WEBrick'] = bench_gem('WEBrick', WEBrick::VERSION, 6469, false)
Process.kill('INT', wt.pid)
=end


# TBD goliath 3
# TBD http-2 4
# TBD passenger 5
# TBD reel 7
# TBD unicor 8


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
