class Hello
  def initialize
    @response =     [ 200,
		      { 'Content-Type' => 'text/html' },
		      [ '<html><h1>Hello World!</h1></html>' ]
		    ]

  end

  def call(req)
    @response
  end
end
