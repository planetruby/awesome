

# Rack

A collection of awesome Rack goodies, libraries, tools, extensions, guides, etc.

#### _Contributions welcome. Anything missing? Send in a pull request. Thanks._


## Rack HQ

_A Ruby Webserver Interface - mix-n-match web servers and web apps; stack web apps inside web apps inside web apps_

(web: [rack.github.io](http://rack.github.io), github: [rack/rack](https://github.com/rack/rack), gem: [rack](https://rubygems.org/gems/rack))


Simple App Examples:

~~~
class HelloWorld
  def call(env)
    [200, {"Content-Type" => "text/plain"}, ["Hello, world!"]]
  end
end
~~~

or

~~~
Proc.new { |env| [200, {"Content-Type" => "text/plain"}, ["Hello, world!"]] }
~~~

or

~~~
->(env) { [200, {"Content-Type" => "text/plain"}, ["Hello, world!"]] }
~~~




## Middleware

Example:

~~~
class ResponseTimer
  def initialize(app)
    @app = app
  end
  
  def call(env)
    start = Time.now
    status, headers, response = @app.call(env)
    stop = Time.now
    if headers["Content-Type"].include? "text/html"
      [status, headers, "<!-- Response Time: #{stop - start} -->\n" + response.body]
    else
      [status, headers, response]
    end
  end
end
~~~

**Rack::File** (github: [rack/lib/rack/file.rb](https://github.com/rack/rack/blob/master/lib/rack/file.rb))

Serves static files below the root directory given, according to the
path info of the Rack request e.g. when Rack::File.new("/etc") is used, 
you can access 'passwd' file as http://localhost:9292/passwd

Note: Handlers can detect if bodies are a Rack::File, and use mechanisms
like sendfile on the path.

Example:

~~~
use Rack::File, ??
~~~

**Rack::ShowExceptions** (github: [rack/lib/rack/show_exceptions.rb](https://github.com/rack/rack/blob/master/lib/rack/show_exceptions.rb))

Catches all exceptions raised from the app it wraps; shows a useful backtrace with the sourcefile and
clickable context, the whole Rack environment and the request data in an helpful 500-page.

~~~
use Rack::ShowExceptions
~~~

**Rack::CommonLogger** (github: [rack/lib/rack/common_logger.rb](https://github.com/rack/rack/blob/master/lib/rack/common_logger.rb))

Does Apache-style logs. Note: If the logger c'tor argument is nil, CommonLogger will fall back rack.errors, which is
an instance of Rack::NullLogger. logger can be any class, including the standard library Logger, and is
expected to have either write or << method, which accepts the CommonLogger::FORMAT.

~~~
use Rack::commonLogger, ???
~~~




**Rack::Sendfile** (github: [rack/lib/rack/sendfile.rb](https://github.com/rack/rack/blob/master/lib/rack/sendfile.rb)) - _rails_

Sets server specific X-Sendfile header.

**Rack::Lock** (github: [rack/lib/rack/lock.rb](https://github.com/rack/rack/blob/master/lib/rack/lock.rb)) - _rails_

Sets env["rack.multithread"] flag to false and wraps the application within a Mutex.

**Rack::Runtime** (github: [rack/lib/rack/runtime.rb](https://github.com/rack/rack/blob/master/lib/rack/runtime.rb)) -  _rails_

Sets an X-Runtime header, containing the time (in seconds) taken to execute the request.

**Rack::MethodOverride** (github: [rack/lib/rack/method_override.rb](https://github.com/rack/rack/blob/master/lib/rack/method_override.rb)) -  _rails_

Allows the method to be overridden if params[:_method] is set. 
This is the middleware which supports the PUT and DELETE HTTP method types.

**Rack::Head** (github: [rack/lib/rack/head.rb](https://github.com/rack/rack/blob/master/lib/rack/head.rb))  - _rails_

Converts HEAD requests to GET requests and serves them as so.


**Rack::ConditionalGet** (github: [rack//lib/rack/conditional_get.rb](https://github.com/rack/rack/blob/master/lib/rack/conditional_get.rb))  - _rails_

Adds support for "Conditional GET" using If-None-Match and If-Modified-Since
so that server responds with nothing if page wasn't changed.


**Rack::ETag** (github: [rack/lib/rack/etag.rb](https://github.com/rack/rack/blob/master/lib/rack/etag.rb))  - _rails_

Adds ETag header on all String bodies. ETags are used to validate cache.




### Routing

**Rack::URLMap** (github: [rack/lib/rack/urlmap.rb](https://github.com/rack/rack/blob/master/lib/rack/urlmap.rb))

A very simple router - redirects to different Rack applications depending on the path and host.
C'tor takes a hash mapping urls or paths to apps, and dispatches accordingly.
Support for HTTP/1.1 host names exists if the URLs start with http:// or https://.

URLMap modifies the SCRIPT_NAME and PATH_INFO such that the part
relevant for dispatch is in the SCRIPT_NAME, and the rest in the
PATH_INFO.  This should be taken care of when you need to
reconstruct the URL in order to create links.

Note: URLMap dispatches in such a way that the longest paths are tried first, since they are most specific.




### Rails on Rack

- [Rails on Rack Guide](http://guides.rubyonrails.org/rails_on_rack.html)

Use

~~~
$ bin/rake middleware
~~~

to show the middleware stack in use. Resulting in:

~~~
use Rack::Sendfile
use ActionDispatch::Static
use Rack::Lock
use #<ActiveSupport::Cache::Strategy::LocalCache::Middleware:0x000000029a0838>
use Rack::Runtime
use Rack::MethodOverride
use ActionDispatch::RequestId
use Rails::Rack::Logger
use ActionDispatch::ShowExceptions
use ActionDispatch::DebugExceptions
use ActionDispatch::RemoteIp
use ActionDispatch::Reloader
use ActionDispatch::Callbacks
use ActiveRecord::Migration::CheckPending
use ActiveRecord::ConnectionAdapters::ConnectionManagement
use ActiveRecord::QueryCache
use ActionDispatch::Cookies
use ActionDispatch::Session::CookieStore
use ActionDispatch::Flash
use ActionDispatch::ParamsParser
use Rack::Head
use Rack::ConditionalGet
use Rack::ETag
run Rails.application.routes
~~~




## Alternatives

- **the_metal** (github: [tenderlove/the_metal](https://github.com/tenderlove/the_metal)) - a spike for thoughts about Rack 2.0 by Aaron Patterson



## Meta

**License**

The awesome list is dedicated to the public domain. Use it as you please with no restrictions whatsoever.

**Questions? Comments?**

Send them along to the ruby-talk mailing list. Thanks!
