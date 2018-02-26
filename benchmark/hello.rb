class Hello
  RESPONSE = [ 200,
	       { 'Content-Type' => 'text/html' }.freeze,
	       [ '<html><h1>Hello Rack World!</h1></html>' ].freeze
	     ].freeze

  def call(env)
    RESPONSE
  end
end
