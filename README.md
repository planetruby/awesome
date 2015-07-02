Awesome Series @ Planet Ruby

[Rubies (Virtual Machines, Compilers, ...)](https://github.com/planetruby/awesome-rubies) • 
[ActiveRecord](https://github.com/planetruby/awesome-activerecord)  •
[Webframeworks (Micro, Macro, APIs, ...)](https://github.com/planetruby/awesome-webframeworks) •
[Webservers (Single-Threaded, Multi-Threaded, Multi-Plexed, ...)](https://github.com/planetruby/awesome-webservers) •
[Static Generators (Sites, Books, Presentations, ...)](https://github.com/planetruby/awesome-staticgen) •
[Events (Conferences, Camps, Meetups, ...)](https://github.com/planetruby/awesome-events) •
[Blogs (News, Opinions, Podcasts, ...)](https://github.com/planetruby/awesome-blogs)


# Webservers

A collection of awesome Ruby web servers (single-threaded, multi-threaded, multi-plexed, etc.)

#### _Contributions welcome. Anything missing? Send in a pull request. Thanks._

[Simple Single-Threaded Web Server](#simple-single-threaded-web-server) •
[Multi-Threaded Web Server](#multi-threaded-web-server) •
[Multi-Process Web Server](#multi-process-web-server) •
[Async I/O, Multi-Plexed "Evented" Web Server](#async-io-multi-plexed-evented-web-server) •
[More Web Servers](#more-web-servers) •
[Misc (Web) Server Machines / Building Blocks](#mics-web-server-machines)

Note: :octocat: stands for the GitHub page and :gem: for the RubyGems page.



## Simple Single-Threaded Web Server

- [WEBrick :octocat:](https://github.com/ruby/ruby/blob/trunk/lib/webrick.rb) - a HTTP server toolkit; ships with the standard library (stdlib); lets you use HTTP(S) servers, proxy servers, and virtual-host servers; by Masayoshi Takahashi, Yuuzou Gotou et al

~~~
require 'webrick'
server = WEBrick::HTTPServer.new :Port => 1234
server.mount '/', WEBrick::HTTPServlet::FileHandler, './'
trap('INT') { server.stop }
server.start
~~~


## Multi-Threaded Web Server

- [Passenger HQ](https://www.phusionpassenger.com) **c++** - [:octocat:](https://github.com/phusion/passenger), [:gem:](https://rubygems.org/gems/passenger) - also known as "Raptor"; C++ core, zero-copy architecture, watchdog system and hybrid evented, multi-threaded and multi-process design by Phusion Inc.

- [Puma HQ](http://puma.io) **c, ragel** - [:octocat:](https://github.com/puma/puma), [:gem:](https://rubygems.org/gems/puma) - a simple, fast, threaded, and highly concurrent HTTP 1.1 server for rack apps by Evan Phoenix et al


## Multi-Process Web Server

- [Unicorn HQ](http://unicorn.bogomips.org) **c**- [(git)](http://bogomips.org/unicorn.git), [:github: mirror](https://github.com/defunkt/unicorn), [:gem:](https://rubygems.org/gems/unicorn) - a HTTP server for rack apps and Unix; workers all run within their own isolated address space and only serve one client at a time for maximum robustness by Eric Wong et al


## Async I/O, Multi-Plexed "Evented" Web Server 

- [Thin HQ](http://code.macournoyer.com/thin) **c, ragel** - [:octocat:](https://github.com/macournoyer/thin), [:gem:](https://rubygems.org/gems/thin) - a simple and fast web server; powered by event machine by Marc-André Cournoyer et al

- [Goliath HQ](http://goliath.io) - [:octocat:](https://github.com/postrank-labs/goliath), [:gem:](https://rubygems.org/gems/goliath) - non-blocking (async) web server framework; powered by event machine; uses fibers to untangle the complicated callback-based code into "plain old" linear-execution

- [Reel HQ :octocat:](https://github.com/celluloid/reel) - [:gem:](https://rubygems.org/gems/reel) -  a fast, non-blocking "evented" web server built on Celluloid::IO; by Tony Arcieri et al


## Misc (Web) Server Machines / Building Blocks

- [Event Machine HQ](http://rubyeventmachine.com) **c** - [:octocat:](https://github.com/eventmachine/eventmachine), [:gem:](https://rubygems.org/gems/eventmachine) -  a fast, single-threaded engine for arbitrary network communications; wraps all interactions with IP sockets, allowing programs  to focus on coding the network protocols; works for both network servers and clients; by Francis Cianfrocca, Aman Gupta et al

- [Celluloid:IO HQ :octocat:](https://github.com/celluloid/celluloid-io), [:gem:](https://rubygems.org/gems/celluloid-io) - evented I/O for celluloid actors; build fast evented programs like you would with EventMachine or Node.js using regular synchronous libraries based on TCPSocket; by Tony Arcieri et al 


## Feature Matrix

| Server     | Rack   |  Multi-Threaded | Multi-Fiber | Multi-Process | Evented | Watchdog | C Extension |
| :--------  | :----: | :-------------: | :---------: | :-----------: | :-----: | :------: | :---------: |
| Passenger  |  Yes   |    Yes          |   x         |   Yes         |   Yes   |  Yes     |  Yes        |
| Puma       |  Yes   |    Yes          |   x         |   x           |   ??    |   x      |  Yes        |
| Unicorn    |  Yes   |    -x-          |   x         |   Yes         |  ??     |  Yes     |  Yes        | 
| WEBRick    |  Yes   |    -x-          |   x         |   x           |  x      |   x      |  x          |
| Thin       |  Yes   |    Yes          |   x         |   x           |  Yes    |   x      |  Yes        |
| Goliath    |  ??    |    -x-          |  Yes        |   x           |  Yes    |   x      |  Yes        |
| Reel       |  -x-   |    ??           |   x         |   x           |  Yes    |   x      |  ??


(Note: Thin, Goliath, ?? using EventMachine - ; Reel, ?? using Celluloid:IO for evented, non-blocking async I/O)



Todo: What features to add?

- Streaming ?
- Websocket ?



## Tips & Tricks

###  HTTP Server One-Line w/ (r)un Ruby Standard Library

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

Options include:

~~~
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

Source in [`un.rb` :octocat:](https://github.com/ruby/ruby/blob/trunk/lib/un.rb) (search for `def httpd`) e.g.:

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

### thin

~~~
$ thin -h
~~~

resulting in:

~~~
Usage: thin [options] start|stop|restart|config

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

Tuning options:
    -b, --backend CLASS              Backend to use, full classname
    -t, --timeout SEC                Request or command timeout in sec (default: 30)
    -f, --force                      Force the execution of the command
        --max-persistent-conns NUM   Maximum number of persistent connections
                                     (default: 100)
        --threaded                   Call the Rack application in threads [experimental]
        --threadpool-size NUM        Sets the size of the EventMachine threadpool.
                                     (default: 20)

Common options:
    -r, --require FILE               require the library
    -q, --quiet                      Silence all logging
    -D, --debug                      Enable debug logging
    -V, --trace                      Set tracing on (log raw request/response)
    -h, --help                       Show this message
    -v, --version                    Show version
~~~


## Meta

**License**

The awesome list is dedicated to the public domain. Use it as you please with no restrictions whatsoever.

**Questions? Comments?**

Send them along to the ruby-talk mailing list. Thanks!

