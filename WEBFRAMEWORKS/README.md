Awesome Series @ Planet Ruby


# Webframeworks

A collection of awesome Ruby web frameworks, libraries, tools, etc.


#### _Contributions welcome. Anything missing? Send in a pull request. Thanks._


[Rack 'n' Alternatives](#rack-n-alternatives) •
[Ruby on Rails](#ruby-on-rails) •
[Sinatra](#sinatra) •
[Volt](#volt) •
[Async Web (Socket) Frameworks](#async-web-socket-frameworks) •
[Web Service Frameworks](#web-service-frameworks) •
[Micro Framework Alternatives](#micro-framework-alternatives) •
["Full Stack" Macro Framework Alternatives](#full-stack-macro-framework-alternatives) •
[More / Misc Frameworks](#more--misc-frameworks) •
[Meta](#meta)

<!--
Note: :gem: stands for the RubyGems page, :octocat: stands for the GitHub page and :book: stands for the RubyDoc page.
-->

## Rack 'n' Alternatives

_A Ruby webserver interface - lets you mix-n-match web servers and web frameworks; stack web apps inside web apps inside web apps_

See the [Awesome Rack List »](https://github.com/planetruby/awesome-rack).


## Ruby on Rails

_Batteries Included "Full Stack" Macro Framework_

- **Ruby on Rails** (web: [rubyonrails.org](http://rubyonrails.org), github: [rails/rails](https://github.com/rails/rails), gem: [rails](https://rubygems.org/gems/rails))
    - [News & Updates](http://weblog.rubyonrails.org)

Extensions

- **Hobo** (web: [hobocentral.net](http://hobocentral.net), github: [Hobo/hobo](https://github.com/Hobo/hobo), gem: [hobo](https://rubygems.org/gems/hobo))
    - [News & Updates](http://hobocentral.net/blog)

Future

- **Trailblazer** (web: [trailblazerb.org](http://trailblazerb.org), github: [apotonick/trailblazer](https://github.com/apotonick/trailblazer), gem: [trailblazer](https://rubygems.org/gems/trailblazer)) - a thin layer on top of rails - (gently) enforces encapsulation, a "more" intuitive code structure and giving you a "better" object-oriented architecture by Nick Sutterer et al



## Sinatra

_Micro Framework - Less than two thousand lines of code (<2000 LOC)_

- **Sinatra** (web: [sinatrarb.com](http://sinatrarb.com), github: [sinatra/sinatra](https://github.com/sinatra), gem: [sinatra](https://rubygems.org/gems/sinatra))

Extensions

- **Padrino** (web: [padrinorb.com](http://padrinorb.com), github: [padrino/padrino](https://github.com/padrino), gem:  [padriono](https://rubygems.org/gems/padrino))
    - [News & Updates](http://www.padrinorb.com/blog)

Fun / Hack

- **Almost Sinatra** (github: [rkh/almost-sinatra](https://github.com/rkh/almost-sinatra)) - Sinatra refactored, only six lines of code by Konstantin Haase

Future

- **Mustermann** (web: [rkh.github.io/mustermann](http://rkh.github.io/mustermann), github: [rkh/mustermann](https://github.com/rkh/mustermann), gem: [mustermann](https://rubygems.org/gems/mustermann))  - your personal string matching expert; can be used as a plugin for Sinatra 1.x and will power Sinatra 2.0; by Konstantin Haase et al


## Volt

_Client/Server Isomorphic Framework_

- **Volt** (web: [voltframework.com](http://voltframework.com), github: [voltrb/volt](https://github.com/voltrb), gem: [volt](https://rubygems.org/gems/volt))
    - [News & Updates](http://voltframework.com/blog)

## Async Web (Socket) Frameworks

- **Cramp** (github: [lifo/cramp](https://github.com/lifo/cramp), gem: [cramp](https://rubygems.org/gems/cramp)) - a fully asynchronous realtime web application framework built on top of event machine; providing full-duplex bi-directional communication by Pratik Naik

- **Lattice** (github: [celluloid/lattice](https://github.com/celluloid/lattice), gem: [lattice](https://rubygems.org/gems/lattice)) -  an actor-based web framework built on top of celluloid, reel, and webmachine; designed for realtime apps, end-to-end streaming, and websockets by Tony Arcieri et al

- **Angelo** (github: [kenichi/angelo](https://github.com/kenichi/angelo), gem: [angelo](https://rubygems.org/gems/angelo)) - sinatra-like mini-language for reel (built upon Celluloid::IO, no rack);  supports web sockets and server sent events (SSE) by Kenichi Nakamura



## Web Service Frameworks

_JSON HTTP API Builder_

- **Grape** (web: [intridea.github.io/grape](http://intridea.github.io/grape), github:  [intridea/grape](https://github.com/intridea/grape), gem: [grape](https://rubygems.org/gems/grape)) - a micro-framework for creating REST-like APIs
- **Crêpe** (github: [crepe/crepe](https://github.com/crepe), gem: [crepe](https://rubygems.org/gems/crepe)) - a thin API stack
- **Yaks** (github: [plexus/yaks](https://github.com/plexus/yaks), gem: [yaks](https://rubygems.org/gems/yaks)) - serialize to hypermedia. HAL, JSON API, HALO, collection+JSON etc. by Arne Brasseur et al
- **Praxis** (web: [praxis-framework.io](http://praxis-framework.io), github: [rightscale/praxis](https://github.com/rightscale/praxis), gem: [praxis](https://rubygems.org/gems/praxis)) - a micro framework focusing on the design and coding aspects of creating good APIs quick by Josep M. Blanquer et al

## Micro Framework Alternatives

- **Rum** (github: [chneukirchen/rum](https://github.com/chneukirchen/rum)) - gRand Unified Mapper for rack apps by Christian Neukirchen
- **Cuba** (web: [cuba.is](http://cuba.is), github: [soveran/cuba](https://github.com/soveran/cuba), gem: [cuba](https://rubygems.org/gems/cuba)) - tiny but powerful mapper for rack apps by Michel Martens
- **New York, New York (NYNY)** (web: [alisnic.github.io/nyny](http://alisnic.github.io/nyny), github:  [alisnic/nyny](https://github.com/alisnic/nyny), gem: [nyny](https://rubygems.org/gems/nyny))  -  a tiny (~300 lines of code) web framework on top of rack by Andrei Lisnic
- **Roda** (web: [roda.jeremyevans.net](http://roda.jeremyevans.net), github: [jeremyevans/roda](https://github.com/jeremyevans/roda), gem: [roda](https://rubygems.org/gems/roda))  - a routing tree web framework toolkit by Jeremy Evans
- **Hobbit** (github: [patriciomacadden/hobbit](https://github.com/patriciomacadden/hobbit), gem:  [hobbit](https://rubygems.org/gems/hobbit)) - a minimalistic microframework built on top of rack by Patricio Mac Adden
- **Brooklyn** (github: [luislavena/brooklyn](https://github.com/luislavena/brooklyn)) - a small web tool on top of rack by Luis Lavena
- **Nancy** (web: [guilleiguaran.github.io/nancy](http://guilleiguaran.github.io/nancy), github: [guilleiguaran/nancy](https://github.com/guilleiguaran/nancy), gem: [nancy](https://rubygems.org/gems/nancy)) - Sinatra's little daughter by Guillermo Iguaran
- **Camping** (web: [camping.io](http://camping.io), github: [camping/camping](https://github.com/camping/camping), gem: [camping](https://rubygems.org/gems/camping)) - minature rails for stay-at-home moms; the 4k pocket full-of-gags web microframework
- **Scorched** (web: [scorchedrb.com](http://scorchedrb.com), github: [Wardrop/Scorched](https://github.com/Wardrop/Scorched), gem: [scorched](https://rubygems.org/gems/scorched))  -  light-weight, DRY as a desert, web framework by Tom Wardrop et al


<!--
   more
   Kenji  - https://github.com/kballenegger/kenji    ??
 -->



## "Full Stack" Macro Framework Alternatives

- **Lotus** (web: [lotusrb.org](http://lotusrb.org), github: [lotus/lotus](https://github.com/lotus/lotus), gem: [lotusrb](https://rubygems.org/gems/lotusrb))  - a complete web framework; bringing back object-oriented programming to web development, leveraging a stable API, minimal DSL and plain objects  by Luca Guidi et al
    - [News & Updates](http://lotusrb.org/blog)

<!-- new list -->

- **Pakyow** (web: [pakyow.org](http://pakyow.org), github: [pakyow/pakyow](https://github.com/pakyow/pakyow), gem:  [pakyow](https://rubygems.org/gems/pakyow)) - an open-source framework for the modern web with a view-first development process that's friendly to everyone whether you're a designer or a developer
    - [News & Updates](http://pakyow.org/blog)

<!-- new list -->

- **Ramaze** (web: [ramaze.net](http://ramaze.net), github: [Ramaze/ramaze](https://github.com/Ramaze/ramaze), gem: [ramaze](https://rubygems.org/gems/ramaze)) - a simple, light and modular open-source web application framework by Michael Fellinger et al
    - [News & Updates](http://ramaze.net/blog)

## More / Misc Frameworks

- **Webmachine** (github: [Webmachine/webmachine-ruby](https://github.com/Webmachine/webmachine-ruby), gem: [webmachine](https://rubygems.org/gems/webmachine)) - an HTTP toolkit - a port of the Webmachine in Erlang - for building apps in a declarative way e.g. less concerned with the procedures involved in handling requests directly and more with describing facts about the resources that make up your app; by Sean Cribbs et al



## Thanks

Tony Arcieri • Josep M. Blanquer

## Meta

**License**

The awesome list is dedicated to the public domain. Use it as you please with no restrictions whatsoever.

**Questions? Comments?**

Send them along to the ruby-talk mailing list. Thanks!
