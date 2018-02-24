#!/usr/bin/env ruby

require 'open3'

require 'agoo'
require 'iodine'

while (index = ARGV.index('-I'))
  _,path = ARGV.slice!(index, 2)
  $: << path
end

$server_wait_time = 1.0
$bench_duration = '5'
$rate_con_count = '100'
$lat_con_count = '5'
$results = {}

sleep $server_wait_time

# returns [rate, latency]
def benchPath(path, port)
  rate = 0
  latency = 0
  # Run with more threads and more connections to get the max throughput. If
  # the rate count is 100 and threads is 4 then 400 keep-alive connections are
  # in use. The intent to to see how the server handles higher loads.
  Open3.popen3('perfer', '-p', path, '-t', '4', '-c', $rate_con_count, '-d', $bench_duration, '-k', "127.0.0.1:#{port}") { |_, out, err, pwt|
    s = out.read

    target = 'for a rate of '
    i = s.index(target) + target.size
    j = s.index(' ', i) -1
    rate = s[i..j].to_i
  }
  # Run with a small number of connections to get the best latency.
  Open3.popen3('perfer', '-p', path, '-t', '2', '-c', $lat_con_count, '-d', $bench_duration, '-k', "127.0.0.1:#{port}") { |_, out, err, pwt|
    s = out.read

    target = 'average latency of '
    i = s.index(target) + target.size
    j = s.index(' ', i) -1
    latency = s[i..j].to_f
  }
  [rate, latency]
end

def benchGem(gem, version, port)
  result = { version: version }
  # warm up
  Open3.popen3('perfer', '-p', '/hello', '-d', '1', "127.0.0.1:#{port}") { |_, out, err, pwt|
  }
  rate, latency = benchPath('/hello', port)
  result[:rack_rate] = rate
  result[:rack_latency] = latency
  puts "%-9s    rack: %7d requests/sec % 7.2f milliseconds/request" % [gem, rate, latency]
  
  rate, latency = benchPath('/', port)
  result[:static_rate] = rate
  result[:static_latency] = latency
  puts "%-9s  static: %7d requests/sec % 7.2f milliseconds/request" % [gem, rate, latency]

  result
end

# Agoo benchmarks
_, _, _, wt = Open3.popen3('ruby', '-I', '.', 'agoo_bench.rb')
sleep $server_wait_time
$results['Agoo'] =  benchGem('Agoo', Agoo::VERSION, 6460)
Process.kill('INT', wt.pid)

# Iodine benchmarks
_, _, _, wt = Open3.popen3('iodine', '-p', '6461', 'iodine_bench.ru')
sleep $server_wait_time
$results['Iodine'] =  benchGem('Iodine', Iodine::VERSION, 6461)
Process.kill('INT', wt.pid)

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
