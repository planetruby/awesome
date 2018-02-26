# Awesome Web Server Benchmarks

Benchmarks show how awesome the Web Servers are. First the result.

## Results

| gem       | Rack<br/>throughput<br/>req/sec | Rack<br/>latency<br/>msec/req | Static<br/>throughput<br/>req/sec | Static<br/>latency<br/>msec/req | Version |
|:--------- | -------:| --------:| -------:| --------:| ------- |
| Agoo      |  102631 |     0.05 |  263620 |     0.03 | 1.1.2   |
| Iodine    |   74082 |     0.06 |  125940 |     0.08 | 0.4.16  |
| Puma      |   27516 |     0.19 |   14061 |     0.66 | latest  |
| Thin      |     959 |     3.68 |     205 |     1.29 | 1.7.2   |
| Passenger |     146 |     0.57 |      36 |     0.66 | latest  |

## How To Run

All the code for the benchmarks is in this directory. In preparation for
running the benchmarks, install all the gems and build
[perfer](https://github.com/ohler55/perfer), the driver. `perfer` is used as
the driver push the faster gems to the limit.

In the benchmarks, throughput and latemcy are measured in two different
runs. Throughput benchmarks open up hundreds of connections and use more
threads than the latency runs. This approach saturates the server. Latency
runs back off on the load to determine what the best latency is when there is
no backlog.

Performance of both static asset and Rack requests are measured since web
sites are a combination of both.

## Observations and Notes

* The set up of each web server was different. Some used a `.ru` file and left
  the demultiplexing up to the developer. Others like Agoo, Iodine, and Puma
  provide a mechanism to demultiplex in the gem itself which makes setup
  simplier.

* All tests were run on a 4 core Razer Blade Stealth laptop.

* Goliath raises an exception when exiting. It does not respond when using the
  goliath_bench.rb. Maybe a setup error though it does follow the example
  given.

* HTTP-2 is not a Rack web server so it was not included in the benchmarks.

* Iodine allows for clustering or forking and processing in multiple
  processes. Using multiple processes is only possible in an application if no
  state is maintained in the application since each process (not thread) has
  it's own memory space that is not shared. For this reason benchmarks were
  run in a single process. Iodine is another 50% faster if it is allowed to
  use an additional 3 processes. Those results varied though from the same as
  with 1 worker to 50% better.

* Puma did not have an obvious version string to extract from the gem.

* Reel requires reel-rack to be installed as well as the reel gem. When trying
  to start an exception was raised regarding Celluloid methods. It seems reel
  is no longer being maintained.

* Unicorn always responds with chunked data which is blank so it was removed
  from the benchmarks.

* WEBrick setup was not successful. WEBrick would run but with more than one
  connection many requests were ignored.

## Summary

Agoo is the fastest when a stateful application is used. If a stateless
application is used then Iodine with 4 workers is faster. None of the other
web servers are even close other than Puma which is at least within an order
of magnitude of Iodine and Agoo. Latencies were better with Agoo and Iodine as
well. The top performer for static assets was Agoo.
