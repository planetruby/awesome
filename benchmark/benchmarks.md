# Awesome Web Server Benchmarks





| gem       | Rack<br/>throughput<br/>req/sec | Rack<br/>latency<br/>msec/req | Static<br/>throughput<br/>req/sec | Static<br/>latency<br/>msec/req | Version |
|:--------- | -------:| --------:| -------:| --------:| ------- |
| Agoo      |  130740 |     0.06 |  267404 |     0.03 | 1.1.0   |
| Iodine    |   49858 |     0.13 |   95279 |     0.10 | 0.4.16  |
| Puma      |    8282 |     0.57 |   10970 |     2.18 | ??      |
| Thin      |     218 |     1.54 |    1024 |     4.19 | 1.7.2   |


* Iodine is almost as fast as Agoo in some cases but the results are not
  consistent.

* Puma did not have an obvious version string to extract from the gem.

* The static file support for Rack Handlers use a very simple file reader
  which is not at all efficient. The benchmarks are included but are really
  just an indicator that static file handling must be handled separately.
