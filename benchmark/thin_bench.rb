$LOAD_PATH << '.'

require 'thin'
require 'hello'

$hello = Hello.new

Thin::Server.start('0.0.0.0', 6462) do
  map '/hello' do
    #run Hello.new
    run $hello
  end
  map '/' do
    run Rack::File.new('./root')
  end
end
