
# Websockets

_Real-time server-sent events for the modern web; two-way evented communication between web pages (browsers) and web servers w/o long-polling (looping)_


## Server-Side

[EventMachine-WebSocket](#) •
[Faye Websocket](#) •
[ActionCable](#)


### EventMachine-WebSocket (em-websocket)

_Websocket server powered by EventMachine_

(github: [igrigorik/em-websocket](https://github.com/igrigorik/em-websocket), gem: [em-websocket](https://rubygems.org/gems/em-websocket)) by Ilya Grigorik et al


~~~
require 'em-websocket'

EM.run {
  EM::WebSocket.run( host: "0.0.0.0", port: 8080) do |ws|
    ws.onopen { |handshake|
      puts "WebSocket connection open"
      ws.send "Hello Client, you connected to #{handshake.path}"   # Publish message to the client
    }

    ws.onclose { puts "Connection closed" }

    ws.onmessage { |msg|
      puts "Received message: #{msg}"
      ws.send "Pong: #{msg}"
    }
  end
}
~~~


Ping & Pong - Yes  /
Secure Server (`wss://`) - Yes



### Faye Websocket (faye-websocket)

_Standards-compliant WebSocket server (and client)_ 

(github: [faye/faye-websocket-ruby](https://github.com/faye/faye-websocket-ruby), gem: [faye-websocket](https://rubygems.org/gems/faye-websocket))
by James Coglan

~~~
require 'faye/websocket'

class App
  def call(env) 
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env)

      ws.on :message do |event|
        ws.send(event.data)
      end

      ws.on :close do |event|
        p [:close, event.code, event.reason]
        ws = nil
      end

      ws.rack_response   # Return async Rack response
    else                 
      [200, {'Content-Type' => 'text/plain'}, ['Hello']]  # Normal HTTP request
    end
  end
end
~~~


### ActionCable (Rails)

_Framework for real-time communication over websockets_

(github: [rails/actioncable](https://github.com/rails/actioncable), gem: [actioncable](https://rubygems.org/gems/actioncable))





## Client-Side (Browsers & JavaScript)


- [Can I Use... WebSockets](http://caniuse.com/#feat=websockets) - Internet Explorer 10+, Firefox 6+, Safari 6+, Chrome 14+, Opera 12+

~~~
var socket = new WebSocket( "ws://example.com/server" );

console.log( "Socket State: " + socket.readyState );

socket.onopen = function() {
  console.log( "Socket Status: " + socket.readyState + " (open)" );
}

socket.onclose = function() {
  console.log( "Socket Status: " + socket.readyState + " (closed)" );
}

// receive data from the server
socket.onmessage = function( msg ) {
  console.log( msg.data );
}

// send data to the server
socket.send( "Hello, World!" );
~~~



## Specs / (Proposed) Standards

- [The WebSocket Protocol - RFC #6455](https://tools.ietf.org/html/rfc6455) - by Ian Fette, Alexey Melnikov; Dec 2011; Internet Engineering Task Force (IETF) Request for Comments (RFC) #6455      
- [The WebSocket API](http://www.w3.org/TR/websockets) - by Ian Hickson; Sep 2012; World Wide Web Consortium (W3C); Candidate Recommendation





## Notes

### Wikipedia

- [WebSocket](https://en.wikipedia.org/wiki/WebSocket)


### Docs

- [WebSockets @ Mozilla](https://developer.mozilla.org/en-US/docs/WebSockets)
- [WebSocket API @ Web Platform Docs](https://docs.webplatform.org/wiki/apis/websocket)



### Articles

- [Introducing WebSockets: Bringing Sockets to the Web](http://www.html5rocks.com/en/tutorials/websockets/basics) by Malte Ubl, Eiji Kitamura; Oct 2010; HTML5 Rocks 

#### Ruby

- [WebSockets in the Ruby Ecosystem](http://www.sitepoint.com/websockets-in-the-ruby-ecosystem) by Dhaivat Pandya; July 2015; SitePoint
- [Getting Started with Ruby and WebSockets](https://blog.engineyard.com/2013/getting-started-with-ruby-and-websockets) by Andrew Steward; Sep 2013; EngineYard



## Related

### Server-Sent Events

Note: Server-sent events (SSE) has its own HTTP connection and W3C spec (see EventSource)

- [Server-sent events @ Wikipedia](https://en.wikipedia.org/wiki/Server-sent_events)
- [Server-sent events @ W3C](http://www.w3.org/TR/eventsource)

### Comet

Old (Historic) Version for two-way, server-push communication

- [Comet (programming) @ Wikipedia](https://en.wikipedia.org/wiki/Comet_%28programming%29)

