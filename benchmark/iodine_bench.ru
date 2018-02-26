$LOAD_PATH << '.'

require 'iodine'
require 'hello'

$hello = Hello.new
Iodine::Rack.public = 'root'
app = proc do |env|
  request = Rack::Request.new(env)
  if request.path_info == '/hello'.freeze
    $hello.call(request)
 end
end

run app
