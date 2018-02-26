$LOAD_PATH << '.'

require 'hello'

$hello = Hello.new

class RackHandler
  def call(env)
    path = env['SCRIPT_NAME'] + env['PATH_INFO']
    
    if '/hello' == path
      $hello.call(env)
    else
      begin
	[ 200, { 'Content-Type' => 'text/html' }, [ File.open('./root/' + path).read ]]
      rescue Exception => e
	[ 404, { 'Content-Type' => 'text/plain' }, [ "./root/#{path} not found" ]]
      end
    end
  end
end

run(RackHandler.new)
