class Hello
  def initialize
  end

  def call(req)
    [ 200,
      { 'Content-Type' => 'text/html' },
      [ '<html><h1>Hello World!</h1></html>' ]
    ]
  end
end
