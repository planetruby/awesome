Awesome Series @ Planet Ruby

[Rubies (Virtual Machines, Compilers, ...)](https://github.com/planetruby/awesome-rubies) • 
[ActiveRecord](https://github.com/planetruby/awesome-activerecord)  •
[Webframeworks (Micro, Macro, APIs, ...)](https://github.com/planetruby/awesome-webframeworks) •
[Webservers (Single-Threaded, Multi-Threaded, Evented, ...)](https://github.com/planetruby/awesome-webservers) •
[Static Generators (Sites, Books, Presentations, ...)](https://github.com/planetruby/awesome-staticgen) •
[Events (Conferences, Camps, Meetups, ...)](https://github.com/planetruby/awesome-events) •
[Blogs (News, Opinions, Podcasts, ...)](https://github.com/planetruby/awesome-blogs)


# Webservers

A collection of awesome Ruby web servers (single-threaded, multi-threaded, multiplexed, etc.)

---

[ANNOUNCEMENT] Looking for awesome Ruby Gems? See the [Ruby Gems of the Week Series @ Planet Ruby](http://planetruby.github.io/gems).

---


#### _Contributions welcome. Anything missing? Send in a pull request. Thanks._

[WEBrick](#webrick) •
[Passenger Family](#passenger-family) •
[Puma](#puma) •
[Iodine](#iodine) •
[Agoo](https://github.com/ohler55/agoo) •
[Unicorn 'n' Friends](#unicorn-n-friends) •
[Thin](#thin) •
[Goliath](#goliath) •
[Reel](#reel) •
[HTTP-2](#http-2) •
[Falcon](#falcon)


## Multi-Threaded, Multi-Process, Async I/O, Multiplexed "Evented" Web Server


### WEBrick

_multi-threaded_  

An HTTP server toolkit; ships with the standard library (stdlib); lets you use HTTP(S) servers,
proxy servers, and virtual-host servers;
by Masayoshi Takahashi, Yuuzou Gotou et al

(github: ruby/ruby/lib/[webrick.rb](https://github.com/ruby/ruby/blob/trunk/lib/webrick.rb)+[webrick/**](https://github.com/ruby/ruby/tree/trunk/lib/webrick))  

~~~
require 'webrick'
server = WEBrick::HTTPServer.new :Port => 1234
server.mount '/', WEBrick::HTTPServlet::FileHandler, './'
trap('INT') { server.stop }
server.start
~~~

Ruby     - Yes  |
Rubinius - Yes  |
Java     - Yes


### Passenger Family

[Standard](#standard) •
[Enterprise](#enterprise)

#### Standard

**c++** - _multi-threaded_, _evented_, _multi-process_, _watchdog_

A web server - also known as "Raptor", mod_rails or mod_rack -  with a zero-copy architecture, watchdog system and hybrid evented, multi-threaded and multi-process design;
by Hongli Lai (Phusion B.V.) et al

Note: The "standard" runs single-threaded; for "advanced" higher throughput,
see the commercial enterprise edition.

(web: [phusionpassenger.com](https://www.phusionpassenger.com),
 github: [phusion/passenger](https://github.com/phusion/passenger),
 gem: [passenger](https://rubygems.org/gems/passenger) _depends on rack_)

Ruby     - Yes (Recommended)  |
Rubinius - ??                 |
Java     - No


#### Enterprise (Commercial)




### Puma

**c, ragel**  - _multi-threaded_, _multi-process_

A simple, fast, threaded, and highly concurrent HTTP 1.1 server for rack apps;
(re)uses the Mongrel HTTP parser (in C/Ragel);
allows firing up multiple workers using the `-w` option;
by Evan Phoenix et al

(web: [puma.io](http://puma.io),
 github: [puma/puma](https://github.com/puma/puma),
 gem: [puma](https://rubygems.org/gems/puma) _depends on rack_)

Ruby      - Yes (*)           |
Rubyinius - Yes (Recommended) |
Java      - Yes (Recommended)

Note: (*) Global Interpreter Lock (GIL) in (C)Ruby "blocks" higher multi-threaded throughput

### Iodine

**c**  - _multi-threaded_, _multi-process_, _evented_

A fast, evented, Rack HTTP/1.x and _Websocket_ server for Linux/BSD/macOS (enforces `kqueue` and `epoll`);
Uses C extensively, circumventing The (C)Ruby GIL for IO read/write, parsing and other events.
allows firing up multiple workers using the `-w` option and multiple thread using the `-t` option ;
by Boaz Segev et al

(github: [boazsegev/iodine](https://github.com/boazsegev/iodine),
 gem: [iodine](https://rubygems.org/gems/iodine) _depends on rack_)

Ruby      - Yes (Recommended*)  |
Rubyinius - No                  |
Java      - No

Note: (*) Global Interpreter Lock (GIL) in (C)Ruby "blocks" application code. Iodine runs outside the GIL except when running user code. 

### Agoo

**c**  - _multi-threaded_, _evented_

A fast Rack server and Ruby gem for Linux and macOS. The
[benchmarks](benchmark/benchmarks.md) say it all.

(github: [ohler55/agoo](https://github.com/ohler55/agoo), gem [agoo](https://rubygems.org/gems/agoo))

Ruby      - Yes |
Rubyinius - No  |
Java      - No


### Unicorn & Friends

[Unicorn](#unicorn) •
[Rainbows!](#rainbows) •
[Yahns](#yahns)

#### Unicorn

**c** - _multi-process_

An HTTP server for rack apps and Unix; workers all run within their own isolated address space
and only serve one client at a time for maximum robustness;
by Eric Wong et al

Note: Use Unicorn with a fully-buffering reverse proxy such as nginx for slow clients.
Unicorn will never ever use new-fangled things
like non-blocking async socket I/O, threads, epoll or kqueue for supporting slow clients (long-running requests).

(web: [unicorn.bogomips.org](http://unicorn.bogomips.org),
 git: [unicorn](http://bogomips.org/unicorn.git),
 github mirror: [defunkt/unicorn](https://github.com/defunkt/unicorn),
 gem: [unicorn](https://rubygems.org/gems/unicorn) _depends on rack, kgio_) 

Ruby     - Yes (Recommended)  |
Rubinius - ??                 |
Java     - No                 |
Windows  - No


#### Rainbows!

_multi-process_, _multi-threaded_, _evented_, _eventmachine_, _fibers_

A web server for sleepy apps and slow clients;
based on unicorn, but designed to handle long request/response times and/or slow clients;
Rainbows! is about diversity - network concurrency models supported include: 
Epoll, EventMachine, FiberPool, FiberSpawn, NeverBlock, Revactor,
ThreadPool, ThreadSpawn, WriterThreadPool, WriterThreadSpawn, XEpoll, XEpollThreadPool, 
XEpollThreadSpawn and more;
by Eric Wong et al

(web: [rainbows.bogomips.org](http://rainbows.bogomips.org),
 git: [rainbows](http://bogomips.org/rainbows.git),
 gem: [rainbows](https://rubygems.org/gems/rainbows))


#### Yahns

_multi-threaded_

A multi-threaded, (optionally) multi-process, internally async (no public async API, yet,
just synchronous Rack 1.x), supports Rack streaming and more;
by Eric Wong et al

(web: [yahns.yhbt.net](http://yahns.yhbt.net/README),
 git clone: [yhbt.net/yahns](git://yhbt.net/yahns.git),
 gem: [yahns](https://rubygems.org/gems/yahns)) 



### Thin

**c, ragel** - _evented_, _eventmachine_

A simple and fast web server powered by EventMachine;
(re)uses the Mongrel HTTP parser (in C/Ragel);
by Marc-André Cournoyer et al

(web: [code.macournoyer.com/thin](http://code.macournoyer.com/thin),
 github: [macournoyer/thin](https://github.com/macournoyer/thin),
 gem: [thin](https://rubygems.org/gems/thin) _depends on rack, eventmachine_) 

Ruby     - Yes (Recommended) |
Rubinius - ??                |
Java     - ??


### Goliath

_evented_, _eventmachine_, _fibers_

A non-blocking (async) web server framework; powered by event machine; uses fibers to untangle the complicated callback-based code into "plain old" linear-execution

(web: [goliath.io](http://goliath.io),
 github: [postrank-labs/goliath](https://github.com/postrank-labs/goliath),
 gem: [goliath](https://rubygems.org/gems/goliath) _depends on rack, eventmachine_) 

Ruby     -  Yes (Recommended)  |
Rubinius - ??                  |
Java     - ??



### Reel

**c** - _evented_, _celluloid_, _fibers_

A fast, non-blocking "evented" web server built on Celluloid::IO; 
supports Rack via the [reel-rack](https://github.com/celluloid/reel-rack) addon;
technically "multi-fiber" via Celluloid;
by Tony Arcieri et al

(github: [celluloid/reel](https://github.com/celluloid/reel),
 gem: [reel](https://rubygems.org/gems/reel) _depends on celluloid_)

Ruby     - Yes (Recommended)  |
Rubinius - ??                 |
Java     - Yes (*)

Note: (*) Compatible extension for Java


### HTTP-2

HTTP/2 protocol and HPACK header compression machinery in all Ruby (no C extensions);
includes an `HTTP2::Server` for testing;
by Ilya Grigorik et al

(github: [igrigorik/http-2](https://github.com/igrigorik/http-2),
 gem: [http-2](https://rubygems.org/gems/http-2))


### Falcon

_multi-process_, _multi-threaded_, _evented_, _fibers_

Falcon is a multi-process, multi-fiber rack-compatible HTTP server built on top
of async, async-io, async-container and async-http. Each request is executed
within a lightweight fiber and can block on up-stream requests without stalling
the entire server process. Falcon supports HTTP/1 and HTTP/2 natively;
by Samuel G. D. Williams et al

(github: [socketry/falcon](https://github.com/socketry/falcon),
 gem: [falcon](https://rubygems.org/gems/falcon)
 _depends on async, async-io, async-container, async-http_)

Ruby        - Yes (Recommended)  |
Rubinius    - ??                 |
Java        - Yes                |
TruffleRuby - Yes

* Note: [priority business support](https://github.com/socketry/falcon#priority-business-support) is available.


## (Web) Server Machines / Building Blocks


### Event Machine

**c** - _evented_

A fast, single-threaded engine for arbitrary network communications; wraps all interactions with IP sockets, allowing programs  to focus on coding the network protocols; works for both network servers and clients;
by Francis Cianfrocca, Aman Gupta et al

(web: [rubyeventmachine.com](http://rubyeventmachine.com),
 github:  [eventmachine/eventmachine](https://github.com/eventmachine/eventmachine),
 gem: [eventmachine](https://rubygems.org/gems/eventmachine))

Ruby     -  Yes (Recommended)  |
Rubinius -  ??                 |
Java     -  ??


### Celluloid:IO

**c** - _evented_, _fibers_

Evented I/O for celluloid actors; build fast evented programs like you would with EventMachine or Node.js using regular synchronous libraries based on TCPSocket;
by Tony Arcieri et al

(github: [celluloid/celluloid-io](https://github.com/celluloid/celluloid-io), gem: [celluloid-io](https://rubygems.org/gems/celluloid-io))

Ruby     -  Yes (Recommended) |
Rubinius -  ??                |
Java     -  ??

### Iodine(core)

**c**  - _multi-threaded_, _multi-process_, _evented_

In addition to the C based HTTP and Websocket server, Iodine offers an API for custom protocol design, evented programming and more;
Iodine offloads pressure from (C)Ruby's GIL by using the [facil.io C web framework](https://github.com/boazsegev/facil.io) for the event loop, network reactor, timers, background IO events etc'. 
by Boaz Segev et al

(github: [boazsegev/iodine](https://github.com/boazsegev/iodine), gem: [iodine](https://rubygems.org/gems/iodine))

Ruby     -  Yes (Recommended) |
Rubinius -  ??                |
Java     -  ??


## Feature Matrix

| Server     | Rack     | HTTP/1.1 |  HTTP/1.1 Pipelining  | HTTP/2 | WebSockets |
| :--------  | :------: |:-------: |  :------------------: | :----: | :--------: |
| WEBRick    |  Yes     |  Yes     |   x                   |   x    |  x         |
| Passenger  |  Yes     |  Yes     |   x                   |  ??    |  planned   |
| Puma       |  Yes     |  Yes     |   x                   |   x    |  planned   |
| Iodine     |  Yes     |  Yes     |   Yes                 |   x    |  Yes       |
| Agoo       |  Yes     |  Yes     |   Yes                 |   x    |  planned   |
| Unicorn    |  Yes     |  Yes     |   x                   |   x    |  x         |
| Thin       |  Yes     |  Yes     |   x                   |   x    |  x         |
| Goliath    |  Yes     |  Yes     |   Yes                 |   x    |  x         |
| Reel       |  Yes(*)  |  Yes     |   Yes                 |   x    |  x         |
| HTTP-2     |  ??      |   x      |   ??                  |  Yes   |  x         |
| Falcon     |  Yes     |  Yes     |   x                   |  Yes   |  Yes       |

(Note: Reel supports Rack via reel-rack addon)

Notes on [HTTP Pipelining](https://en.wikipedia.org/wiki/HTTP_pipelining):

-  WEBRick -- couldn't find any information; a quick look over the code on WEBRick didn't turn up anything.
-  Passenger -- couldn't find any information or Passenger.
-  Puma -- found [this closed issue](https://github.com/puma/puma/issues/2), which leads me to believe it doesn't.
-  Iodine -- has pipelining support; confirmed by the author (Boaz Segev).
-  Agoo -- has pipelining support for slow and fast clients
-  Unicorn -- explicitly documents that it does NOT support pipelining.
-  Thin -- there's [an open issue](https://github.com/macournoyer/thin/issues/40) where several people repeatedly claim pipelining is broken.
-  Goliath -- pipelining is an [explicit design goal of Goliath](https://www.igvita.com/2011/10/04/optimizing-http-keep-alive-and-pipelining/)
-  Reel -- has pipelining support; confirmed by the author (Tony Arcieri).
-  Falcon -- has native HTTP/2 support which supersedes HTTP pipelining.

Note: HTTP/2 supports a more advanced model; HTTP/2 is message-oriented and therefore even more advanced than traditional HTTP/1.1 pipelining.



| Server     | Multi-Threaded | Multi-Fiber | Multi-Process | Evented | Watchdog | C Extension |
| :--------  | :------------: | :---------: | :-----------: | :-----: | :------: | :---------: |
| WEBRick    |  Yes           |   x         |    x          |   x     |   x      |   x         |
| Passenger  |  Yes           |   x         |   Yes         |  Yes    |  Yes     |  Yes        |
| Puma       |  Yes           |   x         |   Yes         |   x     |   x      |  Yes        |
| Iodine     |  Yes           |   x         |   Yes         |  Yes    |   x      |  Yes        |
| Agoo       |  Yes           |   x         |  planned      |  Yes    |   x      |  Yes        |
| Unicorn    |   x            |   x         |   Yes         |  Yes    |  Yes     |  Yes        |
| Thin       |  Yes           |   x         |    x          |  Yes    |   x      |  Yes        |
| Goliath    |   x            |  Yes        |    x          |  Yes    |   x      |  Yes        |
| Reel       |  Yes (*)       |  Yes (*)    |    x          |  Yes    |  Yes (*) |  Yes (*)    |
| HTTP-2     |  ??            |   x         |    x          |  Yes    |   x      |   x         |
| Falcon     |  Yes (*)       |  Yes        |    yes        |  Yes    |   x      |   x         |


(Note: Thin, Goliath, ... using EventMachine)

Notes on Reel:

- Reel using Celluloid:IO for evented, non-blocking async I/O
- Reel single-threaded by default but supports [multithreading with Celluloid](https://github.com/celluloid/reel/wiki/Connection-Management-and-Multithreading)
- Reel technically "multi-fiber" via Celluioid
- Reel supports watchdogs via Celluloid supervisors
- Reel uses a C extension on CRuby but has a compatible Java extension for JRuby

Notes on Iodine:

- Supports "thousands of concurrent connections (tested with more then 20K connections)" by requiring `epoll` or `kqueue`.
- Requires a Linux / BSD / macOS operating system (for `epoll` and `kqueue`).
- Supports Multi-Apps both as nested applications and as multiple HTTP listenning ports.

Notes on Falcon:

- Uses hybrid multi-process/multi-thread mode to support C-Ruby, JRuby and TruffleRuby
- Supports 1 million web socket connections
- Pure Ruby, runs on Linux / BSD/ macOS / Windows operating system using fibers
- Experimental Multi-Apps (SNI) support

Todo: What features to add?

- Multi-App
- Streaming ?
- Websocket ?
- Server-sent events (SSE) ?
- Static File Service (i.e., Iodine + Passange)




## Tips & Tricks

### Do It Yourself (DIY) - A Simple HTTP Server From Scratch

_HTTP - just a few lines of plain text describing each request and response sent over a TCP socket_ 

Example: HTTP Request `/index.html` (type in your browser `http://localhost/index.html`)

~~~
GET /index.html HTTP/1.1
Host: localhost
~~~

Example: HTTP Response `/index.html`

~~~
HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Content-Length: 39

<html>
<h1>Hello, World!</h1>
</html>
~~~

Example: `httpd.rb`

~~~
require 'socket'
server = TCPServer.new 80

loop do
  # step 1) accept incoming connection
  socket = server.accept

  # step 2) print the request headers (separated by a blank line e.g. \r\n)
  puts line = socket.readline  until line == "\r\n"

  # step 3) send response

  html = "<html>\r\n"+
         "<h1>Hello, World!</h1>\r\n"+
         "</html>"
  
  socket.write "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/html; charset=utf-8\r\n" +
               "Content-Length: #{html.bytesize}\r\n"

  socket.write "\r\n"  # write a blank line to separate headers from the html doc
  socket.write html    # write out the html doc

  # step 4) close the socket, terminating the connection
  socket.close
end
~~~

###  HTTP Server One-Liner w/ (r)un Ruby Standard Library

Starting a super simple HTTP server - uses the builtin WEBrick machinery - with an one-liner. Example:

~~~
$ ruby -run -e httpd .       # . is the DocumentRoot e.g. current working folder
=> [2016-08-02 19:14:35] INFO  WEBrick::HTTPServer#start: pid=4396 port=80
~~~

or with a different port and document root e.g.:

~~~
$ ruby -run -e httpd ./_site -p 5000
=> [2016-08-02 19:14:35] INFO  WEBrick::HTTPServer#start: pid=4397 port=5000
~~~

or to get all options:

~~~
$ ruby -e "require 'un'; httpd" -- --help
~~~

resulting in:

~~~
Run WEBrick HTTP server.

  ruby -run -e httpd -- [OPTION] DocumentRoot

  --bind-address=ADDR         address to bind
  --port=NUM                  listening port number
  --max-clients=MAX           max number of simultaneous clients
  --temp-dir=DIR              temporary directory
  --do-not-reverse-lookup     disable reverse lookup
  --request-timeout=SECOND    request timeout in seconds
  --http-version=VERSION      HTTP version
  -v                          verbose
~~~

Source in ruby/ruby/lib/[un.rb](https://github.com/ruby/ruby/blob/trunk/lib/un.rb) (search for the `httpd` method) e.g.:

~~~
def httpd
  setup("", "BindAddress=ADDR", "Port=PORT", "MaxClients=NUM", "TempDir=DIR",
        "DoNotReverseLookup", "RequestTimeout=SECOND", "HTTPVersion=VERSION") do
    |argv, options|
    require 'webrick'
    opt = options[:RequestTimeout] and options[:RequestTimeout] = opt.to_i
    [:Port, :MaxClients].each do |name|
      opt = options[name] and (options[name] = Integer(opt)) rescue nil
    end
    options[:Port] ||= 8080     # HTTP Alternate
    options[:DocumentRoot] = argv.shift || '.'
    s = WEBrick::HTTPServer.new(options)
    shut = proc {s.shutdown}
    siglist = %w"TERM QUIT"
    siglist.concat(%w"HUP INT") if STDIN.tty?
    siglist &= Signal.list.keys
    siglist.each do |sig|
      Signal.trap(sig, shut)
    end
    s.start
  end
end
~~~


## Command Line Tools

### Passenger

~~~
$ passenger -h
~~~

resulting in:

~~~
Phusion Passenger Standalone, the easiest way to run web apps.

Available commands:

  passenger start      Start Phusion Passenger Standalone.
  passenger stop       Stop a Phusion Passenger instance.
  passenger status     Show the status of a running Phusion Passenger instance.
~~~

~~~
$ passenger start --help
~~~

resulting in:

~~~
Usage: passenger start [DIRECTORY] [OPTIONS]
Starts Phusion Passenger Standalone and serve one or more web applications.

Server options:
    -a, --address HOST               Bind to the given address. Default: 0.0.0.0
    -p, --port NUMBER                Use the given port number. Default: 3000
    -S, --socket FILE                Bind to Unix domain socket instead of TCP socket
        --ssl                        Enable SSL support (Nginx engine only)
        --ssl-certificate PATH       Specify the SSL certificate path (Nginx engine only)
        --ssl-certificate-key PATH   Specify the SSL key path
        --ssl-port PORT              Listen for SSL on this port, while listening for HTTP on the normal port (Nginx engine only)
    -d, --daemonize                  Daemonize into the background
        --user USERNAME              User to run as. Ignored unless running as root
        --log-file FILENAME          Where to write log messages. Default: console, or /dev/null when daemonized
        --pid-file FILENAME          Where to store the PID file
        --instance-registry-dir PATH Use the given instance registry directory
        --data-buffer-dir PATH       Use the given data buffer directory

Application loading options:
    -e, --environment ENV            Framework environment. Default: development
        --ruby FILENAME              Executable to use for Ruby apps. Default: /home/gerald/.rvm/gems/ruby-2.1.4/wrappers/ruby (current context)
    -R, --rackup FILE                Consider application a Ruby app, and use the given rackup file
        --app-type NAME              Force app to be detected as the given type
        --startup-file FILENAME      Force given startup file to be used
        --spawn-method NAME          The spawn method to use. Default: smart
        --static-files-dir PATH      Specify the static files dir (Nginx engine only)
        --restart-dir PATH           Specify the restart dir
        --friendly-error-pages       Turn on friendly error pages
        --no-friendly-error-pages    Turn off friendly error pages
        --load-shell-envvars         Load shell startup files before loading application
        --debugger                   Enable debugger support

Process management options:
        --max-pool-size NUMBER       Maximum number of application processes. Default: 6
        --min-instances NUMBER       Minimum number of processes per application. Default: 1
        --pool-idle-time SECONDS     Maximum time that processes may be idle. Default: 300
        --max-preloader-idle-time SECONDS  Maximum time that preloader processes may be idle. A value of 0 means that preloader processes never timeout. Default: 300
        --concurrency-model NAME     The concurrency model to use, either 'process' or 'thread' (Enterprise only). Default: process
        --thread-count NAME          The number of threads to use when using the 'thread' concurrency model (Enterprise only). Default: 1
        --rolling-restarts           Enable rolling restarts (Enterprise only)
        --resist-deployment-errors   Enable deployment error resistance (Enterprise only)

Request handling options:
        --max-request-time SECONDS   Abort requests that take too much time (Enterprise only)
        --sticky-sessions            Enable sticky sessions
        --sticky-sessions-cookie-name NAME   Cookie name to use for sticky sessions. Default: _passenger_route
        --vary-turbocache-by-cookie NAME     Vary the turbocache by the cookie of the given name
        --disable-turbocaching       Disable turbocaching
...
~~~


### Puma

~~~
$ puma -h
~~~

resulting in:

~~~
puma <options> <rackup file>
    -b, --bind URI                   URI to bind to (tcp://, unix://, ssl://)
    -C, --config PATH                Load PATH as a config file
        --control URL                The bind url to use for the control server
                                     Use 'auto' to use temp unix server
        --control-token TOKEN        The token to use as authentication for the control server
    -d, --daemon                     Daemonize the server into the background
        --debug                      Log lowlevel debugging information
        --dir DIR                    Change to DIR before starting
    -e, --environment ENVIRONMENT    The environment to run the Rack app on (default development)
    -I, --include PATH               Specify $LOAD_PATH directories
    -p, --port PORT                  Define the TCP port to bind to
                                     Use -b for more advanced options
        --pidfile PATH               Use PATH as a pidfile
        --preload                    Preload the app. Cluster mode only
        --prune-bundler              Prune out the bundler env if possible
    -q, --quiet                      Quiet down the output
    -R, --restart-cmd CMD            The puma command to run during a hot restart
                                     Default: inferred
    -S, --state PATH                 Where to store the state details
    -t, --threads INT                min:max threads to use (default 0:16)
        --tcp-mode                   Run the app in raw TCP mode instead of HTTP mode
    -V, --version                    Print the version information
    -w, --workers COUNT              Activate cluster mode: How many worker processes to create
        --tag NAME                   Additional text to display in process listing
    -h, --help                       Show help
~~~

### Iodine

~~~
$ iodine -?
~~~

resulting in:

~~~
Iodine's HTTP/Websocket server version [version]

Use:

    iodine <options> <filename>

Both <options> and <filename> are optional.

Available options:
 -p          Port number. Default: 3000.
 -t          Number of threads. Default: CPU core count.
 -w          Number of worker processes. Default: CPU core count.
 -www        Public folder for static file serving. Default: nil (none).
 -v          Log responses. Default: never log responses.
 -warmup     Warmup invokes autoloading (lazy loading) during server startup.
 -tout       HTTP inactivity connection timeout. Default: 5 seconds.
 -maxbd      Maximum Mb per HTTP message (max body size). Default: 50Mib.
 -maxms      Maximum Bytes per Websocket message. Default: 250Kib.
 -ping       Websocket ping interval in seconds. Default: 40 seconds.
 <filename>  Defaults to: config.ru

Example:

    iodine -p 80

    iodine -p 8080 path/to/app/conf.ru

    iodine -p 8080 -w 4 -t 16

~~~

### Agoo

~~~
$ agoo -h
~~~

resulting in:

~~~
Usage: agoo [options] [<handler_class>@<path>]...

version 1.1.1

Agoo is a Ruby web server. It can be run as a standalone application using this
application. The handler/class arguments must have the form of <class>@<path>
where the class is the Ruby class where the new method takes not arguments and
has either a call() method or a on_request() method.

    -h, --help                       Show this display.
    -s, --silent                     Silent.
    -v, --verbose                    Increase verbosity.
    -p, --port PORT                  Port to listen on.
    -d, --dir DIR                    Directory to serve static assets from.
    -r, --require FILE               Ruby require.
        --log.dir DIR                Log file directory.
        --[no-]log.classic           Classic log entries instead of JSON.
        --[no-]log.console           Display log entries on the console.
        --[no-]log.colorize          Display log entries in color.
~~~

### Unicorn

~~~
$ unicorn -h
~~~

resulting in:

~~~
Usage: unicorn [ruby options] [unicorn options] [rackup config file]
Ruby options:
  -e, --eval LINE          evaluate a LINE of code
  -d, --debug              set debugging flags (set $DEBUG to true)
  -w, --warn               turn warnings on for your script
  -I, --include PATH       specify $LOAD_PATH (may be used more than once)
  -r, --require LIBRARY    require the library, before executing your script
unicorn options:
  -o, --host HOST          listen on HOST (default: 0.0.0.0)
  -p, --port PORT          use PORT (default: 8080)
  -E, --env RACK_ENV       use RACK_ENV for defaults (default: development)
  -N                       do not load middleware implied by RACK_ENV
      --no-default-middleware
  -D, --daemonize          run daemonized in the background

  -s, --server SERVER      this flag only exists for compatibility
  -l {HOST:PORT|PATH},     listen on HOST:PORT or PATH
      --listen             this may be specified multiple times
                           (default: 0.0.0.0:8080)
  -c, --config-file FILE   Unicorn-specific config file
Common options:
  -h, --help               Show this message
  -v, --version            Show version
~~~


### Thin

~~~
$ thin -h
~~~

resulting in:

~~~
Usage: thin [options] start|stop|restart|config|install

Server options:
    -a, --address HOST               bind to HOST address (default: 0.0.0.0)
    -p, --port PORT                  use PORT (default: 3000)
    -S, --socket FILE                bind to unix domain socket
    -y, --swiftiply [KEY]            Run using swiftiply
    -A, --adapter NAME               Rack adapter to use (default: autodetect)
                                     (rack, rails, ramaze, merb, file)
    -R, --rackup FILE                Load a Rack config file instead of Rack adapter
    -c, --chdir DIR                  Change to dir before starting
        --stats PATH                 Mount the Stats adapter under PATH

SSL options:
        --ssl                        Enables SSL
        --ssl-key-file PATH          Path to private key
        --ssl-cert-file PATH         Path to certificate
        --ssl-disable-verify         Disables (optional) client cert requests

Adapter options:
    -e, --environment ENV            Framework environment (default: development)
        --prefix PATH                Mount the app under PATH (start with /)

Daemon options:
    -d, --daemonize                  Run daemonized in the background
    -l, --log FILE                   File to redirect output (default: /home/gerald/test/log/thin.log)
    -P, --pid FILE                   File to store PID (default: tmp/pids/thin.pid)
    -u, --user NAME                  User to run daemon as (use with -g)
    -g, --group NAME                 Group to run daemon as (use with -u)
        --tag NAME                   Additional text to display in process listing

Cluster options:
    -s, --servers NUM                Number of servers to start
    -o, --only NUM                   Send command to only one server of the cluster
    -C, --config FILE                Load options from config file
        --all [DIR]                  Send command to each config files in DIR
    -O, --onebyone                   Restart the cluster one by one (only works with restart command)
    -w, --wait NUM                   Maximum wait time for server to be started in seconds (use with -O)

Tuning options:
    -b, --backend CLASS              Backend to use, full classname
    -t, --timeout SEC                Request or command timeout in sec (default: 30)
    -f, --force                      Force the execution of the command
        --max-conns NUM              Maximum number of open file descriptors (default: 1024)
                                     Might require sudo to set higher than 1024
        --max-persistent-conns NUM   Maximum number of persistent connections
                                     (default: 100)
        --threaded                   Call the Rack application in threads [experimental]
        --threadpool-size NUM        Sets the size of the EventMachine threadpool.
                                     (default: 20)
        --no-epoll                   Disable the use of epoll

Common options:
    -r, --require FILE               require the library
    -q, --quiet                      Silence all logging
    -D, --debug                      Enable debug logging
    -V, --trace                      Set tracing on (log raw request/response)
    -h, --help                       Show this message
    -v, --version                    Show version
~~~


### Falcon

~~~
$ falcon --help
~~~

resulting in:

~~~
falcon [--verbose | --quiet] [-h/--help] [-v/--version] <command>
	An asynchronous HTTP server.

	[--verbose | --quiet]  Verbosity of output for debugging.
	[-h/--help]            Print out help information.
	[-v/--version]         Print out the application version.
	<command>              One of: serve, virtual.             Default: serve

	serve [-b/--bind <address>] [-p/--port <number>] [-h/--hostname <hostname>] [-t/--timeout <duration>] [--reuse-port] [-c/--config <path>] [--forked | --threaded | --hybrid] [-n/--count <count>] [--forks <count>] [--threads <count>]
		Run an HTTP server.

		[-b/--bind <address>]               Bind to the given hostname/address                               Default: https://localhost:9292
		[-p/--port <number>]                Override the specified port
		[-h/--hostname <hostname>]          Specify the hostname which would be used for certificates, etc.
		[-t/--timeout <duration>]           Specify the maximum time to wait for blocking operations.        Default: 60
		[--reuse-port]                      Enable SO_REUSEPORT if possible.                                 Default: false
		[-c/--config <path>]                Rackup configuration file to load                                Default: config.ru
		[--forked | --threaded | --hybrid]  Select a specific parallelism model                              Default: forked
		[-n/--count <count>]                Number of instances to start.                                    Default: 8
		[--forks <count>]                   Number of forks (hybrid only).
		[--threads <count>]                 Number of threads (hybrid only).
~~~


## Glossary / Abbreviations

| Abbrev    |       |
|:--------  | :---- |
| C         | C Programming Language  |
| C++       | C++ Programming Language  |
| HTTP      | Hypertext Transfer Protocol  |
| HTTPD     | HTTP Daemon  |
| HTTPS     | HTTP Secure or HTTP over SSL |
| IO or I/O | Input/Output       |
| IP        | Internet Protocol  |
| PID       | Process Identifier    |
| SSL       | Secure Sockets Layer  |
| TCP       | Transmission Control Protocol  |
| URI       | Uniform Resource Identifier  |
| URL        | Uniform Resource Locator     |

More

| Abbrev    |       |
|:--------  | :---- |
| BV or B.V. | Besloten Venootschap  [nl]  |


## Thanks

Tony Arcieri • Michael Dippery • Uwe Kubosch • Hongli Lai • Eric Wong


## Meta

**License**

The awesome list is dedicated to the public domain. Use it as you please with no restrictions whatsoever.

**Questions? Comments?**

Send them along to the ruby-talk mailing list. Thanks!

