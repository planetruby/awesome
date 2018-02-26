# Code Examples

## Code Examples


### Agoo - Hello World - #rack

~~~
require 'agoo'

class Hello
  def call(req)
    [ 200, { 'Content-Type' => 'text/html' }, [ '<html><h1>Hello World!</h1></html>' ]]
  end
end

server = Agoo::Server.new(6460, 'root', thread_count: 0)

server.handle(:GET, "/hello", Hello.new)
server.start()

~~~

### Thin - Hello World - #rack

~~~
require 'thin'

class SimpleAdapter
  def call(env)
    body = ["Hello, World!"]
    [
      200,
      { 'Content-Type' => 'text/plain' },
      body
    ]
  end
end

Thin::Server.start('0.0.0.0', 3000) do
  use Rack::CommonLogger
  map '/test' do
    run SimpleAdapter.new
  end
  map '/files' do
    run Rack::File.new('.')
  end
end
~~~

### Goliath - Hello World

~~~
require 'goliath'

class HelloWorld < Goliath::API
  def response(env)
    [200, {}, "Hello, World!"]
  end
end
~~~

(Source: [`hello_world.rb`](https://github.com/postrank-labs/goliath/blob/master/examples/hello_world.rb))


### Reel - Hello World

~~~
require 'reel'

addr, port = '127.0.0.1', 1234

puts "*** Starting server on http://#{addr}:#{port}"
Reel::Server::HTTP.run(addr, port) do |connection|
  # For keep-alive support
  connection.each_request do |request|
    # Ordinarily we'd route the request here, e.g.
    # route request.url
    request.respond :ok, "Hello, World!"
  end

  # Reel takes care of closing the connection for you
  # If you would like to hand the connection off to another thread or actor,
  # use, connection.detach and then manually call connection.close when done
end
~~~

(Source: [`hello_world.rb`](https://github.com/celluloid/reel/blob/master/examples/hello_world.rb))



### EventMachine - Echo Server

~~~
require 'eventmachine'

module EchoServer
  def post_init
    puts "-- someone connected to the echo server!"
  end

  def receive_data data
    send_data ">>>you sent: #{data}"
    close_connection if data =~ /quit/i
  end

  def unbind
    puts "-- someone disconnected from the echo server!"
  end
end

EventMachine.run {
  EventMachine.start_server "127.0.0.1", 8081, EchoServer     # Note: This will block current thread.
}
~~~



### Celluloid::IO - Echo Server

~~~
require 'celluloid/io'
require 'celluloid/autostart'

class EchoServer
  include Celluloid::IO
  finalizer :shutdown

  def initialize(host, port)
    puts "*** Starting echo server on #{host}:#{port}"

    # Since we included Celluloid::IO, we're actually making a
    # Celluloid::IO::TCPServer here
    @server = TCPServer.new(host, port)
    async.run
  end

  def shutdown
    @server.close if @server
  end

  def run
    loop { async.handle_connection @server.accept }
  end

  def handle_connection(socket)
    _, port, host = socket.peeraddr
    puts "*** Received connection from #{host}:#{port}"
    loop { socket.write socket.readpartial(4096) }
  rescue EOFError
    puts "*** #{host}:#{port} disconnected"
    socket.close
  end
end
~~~

(Source: [`echo_server.rb`](https://github.com/celluloid/celluloid-io/blob/master/examples/echo_server.rb))
