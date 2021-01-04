# Awesome Functional [Programming (FP)]

A collection of all awesome things functional in ruby (incl. functional-style programming, pattern matching, immutability, and more)

_Contributions welcome. Anything missing? Send in a pull request. Thanks._



## Quotes & Comments

> In reality, the idea [functional programming (FP) in ruby] is simple, and it boils down to three key points:
>
> - Stop relying on mutable state
> - Separate data from behavior
> - Embrace #call as the primary interface for most objects,
>   where everything is designed as a data pipeline: data-in, data-out, that's it.
>
>  Source: [Piotr Solnica @ Redddit](https://www.reddit.com/r/ruby/comments/7y7gvw/functional_programming_in_ruby/)



## Articles

### Functional-Stye Programming Series by Tom Dalling @ Ruby Pigeon

- **[A Review Of Immutability In Ruby](https://www.rubypigeon.com/posts/a-review-of-immutability-in-ruby)**  by Tom Dalling, Ruby Pigeon, June 2016
- **[Avoid Mutation – Functional Style In Ruby](https://www.rubypigeon.com/posts/avoid-mutation-functional-style-in-ruby)**  by Tom Dalling, Ruby Pigeon, July 2016
- **[Isolate Side Effects – Functional Style in Ruby](https://www.rubypigeon.com/posts/isolate-side-effects-functional-style-in-ruby)**   by Tom Dalling, Ruby Pigeon, July 2016




## Libraries / Gems


### Freezing / Immutability

**Ice Nine** (github: [dkubb/ice_nine](https://github.com/dkubb/ice_nine), gem: [ice_nine](https://rubygems.org/gems/ice_nine)) by Dan Kubb et al  - Deep (Recursive) Freeze Ruby Objects

```ruby
require 'ice_nine'

# Deep freezes most kinds of objects
hash   = IceNine.deep_freeze('a' => '1')
array  = IceNine.deep_freeze([ 'a', 'b', 'c' ])
range  = IceNine.deep_freeze('a'..'z')
struct = IceNine.deep_freeze(Struct.new(:a, :b).new('a', 'b'))
object = IceNine.deep_freeze(Object.new)
user   = IceNine.deep_freeze(User.new(name: 'dkubb'))

# Faster deep freeze that skips deep-freezing frozen objects
object = IceNine.deep_freeze!(Object.new)

# Add core extension for Object#deep_freeze (not required by default)
require 'ice_nine'
require 'ice_nine/core_ext/object'

object = Object.new
object.deep_freeze
```


### All-in-One

**Functional Ruby** (github: [functional-ruby](https://github.com/jdantonio/functional-ruby), gem: [functional-ruby](https://rubygems.org/gems/functional-ruby)) by Jerry D'Antonio et al 

- Protocol specifications inspired by Clojure [protocol](http://clojure.org/protocols),
  Erlang [behavior](http://www.erlang.org/doc/design_principles/des_princ.html#id60128),
  and Objective-C [protocol](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithProtocols/WorkingwithProtocols.html).
- Function overloading with Erlang-style [function](http://erlang.org/doc/reference_manual/functions.html)
  [pattern matching](http://erlang.org/doc/reference_manual/patterns.html).
- Simple, thread safe, immutable data structures, such as `Record`, `Union`, and `Tuple`, inspired by
  [Clojure](http://clojure.org/datatypes), [Erlang](http://www.erlang.org/doc/reference_manual/records.html),
  and other functional languages.
- Thread safe, immutable `Either` and `Option` classes based on [Functional Java](http://functionaljava.org/) and [Haskell](https://hackage.haskell.org/package/base-4.2.0.1/docs/Data-Either.html).
- [Memoization](http://en.wikipedia.org/wiki/Memoization) of class methods based on Clojure [memoize](http://clojuredocs.org/clojure_core/clojure.core/memoize).
- Lazy execution with a `Delay` class based on Clojure [delay](http://clojuredocs.org/clojure_core/clojure.core/delay).
- `ValueStruct`, a simple, thread safe, immutable variation of Ruby's [OpenStruct](http://ruby-doc.org/stdlib-2.0/libdoc/ostruct/rdoc/OpenStruct.html) class.
- Thread safe data structures, such as `FinalStruct` and `FinalVar`, which can be written to at most once
  before becoming immutable. Based on [Java's `final` keyword](http://en.wikipedia.org/wiki/Final_(Java)).

```ruby
class Foo
  include Functional::PatternMatching
  include Functional::Protocol
  include Functional::TypeCheck

  def greet
    return 'Hello, World!'
  end

  defn(:greet, _) do |name|
    "Hello, #{name}!"
  end

  defn(:greet, _) { |name|
    "Pleased to meet you, #{name.full_name}!"
  }.when {|name| Type?(name, CustomerModel, ClientModel) }

  defn(:greet, _) { |name|
    "Hello, #{name.first} #{name.last}!"
  }.when {|name| Satisfy?(name, :Name) }

  defn(:greet, :doctor, _) { |name|
    "Hello, Dr. #{name}!"
  }

  defn(:greet, nil, _) { |name|
    "Goodbye, #{name}!"
  }

  defn(:greet, _, _) { |_, name|
    "Hello, #{name}!"
  }
end
```

## Meta

**License**

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The awesome list is dedicated to the public domain. Use it as you please with no restrictions whatsoever.
