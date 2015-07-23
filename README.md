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
[Unicorn 'n' Friends](#unicorn-n-friends) •
[Thin](#thin) •
[Goliath](#goliath) •
[Reel](#reel) •
[HTTP-2](#http-2)


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



## Feature Matrix

| Server     | Rack     | HTTP/1.1 |  HTTP/1.1 Pipelining  | HTTP/2 |
| :--------  | :------: |:-------: |  :------------------: | :----: |
| WEBRick    |  Yes     |  Yes     |   x                   |   x    |
| Passenger  |  Yes     |  Yes     |   x                   |  ??    |
| Puma       |  Yes     |  Yes     |   x                   |   x    |
| Unicorn    |  Yes     |  Yes     |   x                   |   x    |
| Thin       |  Yes     |  Yes     |   x                   |   x    |
| Goliath    |  Yes     |  Yes     |   Yes                 |   x    |
| Reel       |  Yes(*)  |  Yes     |   Yes                 |   x    |
| HTTP-2     |  ??      |   x      |   ??                  |  Yes   |

(Note: Reel supports Rack via reel-rack addon)

Notes on [HTTP Pipelining](https://en.wikipedia.org/wiki/HTTP_pipelining):

-  WEBRick -- couldn't find any information; a quick look over the code on WEBRick didn't turn up anything.
-  Passenger -- couldn't find any information or Passenger.
-  Puma -- found [this closed issue](https://github.com/puma/puma/issues/2), which leads me to believe it doesn't.
-  Unicorn -- explicitly documents that it does NOT support pipelining.
-  Thin -- there's [an open issue](https://github.com/macournoyer/thin/issues/40) where several people repeatedly claim pipelining is broken.
-  Goliath -- pipelining is an [explicit design goal of Goliath](https://www.igvita.com/2011/10/04/optimizing-http-keep-alive-and-pipelining/)
-  Reel -- has pipelining support; confirmed by the author (Tony Arcieri).

Note: HTTP/2 supports a more advanced model; HTTP/2 is message-oriented and therefore even more advanced than traditional HTTP/1.1 pipelining.



| Server     | Multi-Threaded | Multi-Fiber | Multi-Process | Evented | Watchdog | C Extension |
| :--------  | :------------: | :---------: | :-----------: | :-----: | :------: | :---------: |
| WEBRick    |  Yes           |   x         |    x          |   x     |   x      |   x         |
| Passenger  |  Yes           |   x         |   Yes         |  Yes    |  Yes     |  Yes        |
| Puma       |  Yes           |   x         |   Yes         |   x     |   x      |  Yes        |
| Unicorn    |   x            |   x         |   Yes         |  Yes    |  Yes     |  Yes        | 
| Thin       |  Yes           |   x         |    x          |  Yes    |   x      |  Yes        |
| Goliath    |   x            |  Yes        |    x          |  Yes    |   x      |  Yes        |
| Reel       |  Yes (*)       |  Yes (*)    |    x          |  Yes    |  Yes (*) |  Yes (*)    |
| HTTP-2     |  ??            |   x         |    x          |  Yes    |   x      |   x         |


(Note: Thin, Goliath, ... using EventMachine)

Notes on Reel:

- Reel using Celluloid:IO for evented, non-blocking async I/O
- Reel single-threaded by default but supports [multithreading with Celluloid](https://github.com/celluloid/reel/wiki/Connection-Management-and-Multithreading)
- Reel technically "multi-fiber" via Celluioid
- Reel supports watchdogs via Celluloid supervisors
- Reel uses a C extension on CRuby but has a compatible Java extension for JRuby


Todo: What features to add?

- Multi-App
- Streaming ?
- Websocket ?
- Server-sent events (SSE) ?




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
$ ruby -run -e httpd -- --help
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

