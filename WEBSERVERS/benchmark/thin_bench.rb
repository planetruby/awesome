$LOAD_PATH << '.'

require 'thin'
require 'hello'

$hello = Hello.new

Thin::Server.start('0.0.0.0', 6467) do
  map '/hello' do
    run $hello
  end
  map '/' do
    run Rack::File.new('./root')
  end
end
