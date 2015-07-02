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

[Multi-Threaded Web Server](#multi-threaded-web-server) •
[Simple Single-Threaded Web Server](#simple-single-threaded-web-server) •
[Async I/O, Multi-Plexed (Single Event Thread) Web Server](#async-io-multi-plexed-single-event-thread-web-server) •
[More Web Servers](#more-web-servers)
[Misc (Web) Server Machines](#mics-web-server-machines)

Note: :octocat: stands for the GitHub page and :gem: for the RubyGems page.


## Multi-Threaded Web Server

- [Passenger HQ](https://www.phusionpassenger.com) - [:octocat:](https://github.com/phusion/passenger), [:gem:](https://rubygems.org/gems/passenger) - also known as "Raptor"; C++ core, zero-copy architecture, watchdog system and 
       hybrid evented, multi-threaded and multi-process design by Phusion Inc.

- [Puma HQ](http://puma.io) - [:octocat:](https://github.com/puma/puma), [:gem:](https://rubygems.org/gems/puma) - a simple, fast, threaded, and highly concurrent HTTP 1.1 server for rack apps by Evan Phoenix et al


## Simple Single-Threaded Web Server

- [Unicorn HQ](http://unicorn.bogomips.org) - [(git)](http://bogomips.org/unicorn.git), [:gem:](https://rubygems.org/gems/unicorn) - a HTTP server for rack apps and Unix/Unix-like kernels; workers all run within their own isolated address space and only serve one client at a time for maximum robustness by Eric Wong et al

- [WEBrick :octocat:](https://github.com/ruby/ruby/blob/trunk/lib/webrick.rb) - included in the standard library (stdlib); a HTTP server toolkit - use as an HTTPS server, a proxy server, and a virtual-host server


## Async I/O, Multi-Plexed (Single Event Thread) Web Server 

- [Thin HQ](http://code.macournoyer.com/thin) - [:octocat:](https://github.com/macournoyer/thin), [:gem:](https://rubygems.org/gems/thin) - a simple and fast web server; powered by event machine by Marc-André Cournoyer et al

- [Goliath HQ](http://goliath.io) - [:octocat:](https://github.com/postrank-labs/goliath), [:gem:](https://rubygems.org/gems/goliath) - non-blocking (async) web server framework; powered by event machine; uses fibers to untangle the complicated callback-based code into "plain old" linear-execution

- [Reel HQ :octocat:](https://github.com/celluloid/reel) - [:gem:](https://rubygems.org/gems/reel) -  a fast, non-blocking "evented" web server built on Celluloid::IO; by Tony Arcieri et al


## Misc (Web) Server Machines

[Event Machine HQ](http://rubyeventmachine.com) - [:octocat:](https://github.com/eventmachine/eventmachine), [:gem:](https://rubygems.org/gems/eventmachine) -  a fast, single-threaded engine for arbitrary network communications; wraps all interactions with IP sockets, allowing programs  to focus on coding the network protocols; works for both network servers and clients; by Francis Cianfrocca, Aman Gupta et al

[Celluloid:IO HQ :octocat:](https://github.com/celluloid/celluloid-io), [:gem:](https://rubygems.org/gems/celluloid-io) - evented I/O for celluloid actors; build fast evented programs like you would with EventMachine or Node.js using regular synchronous libraries based on TCPSocket; by Tony Arcieri et al 


## Meta

**License**

The awesome list is dedicated to the public domain. Use it as you please with no restrictions whatsoever.

**Questions? Comments?**

Send them along to the ruby-talk mailing list. Thanks!

