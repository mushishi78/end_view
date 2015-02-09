# EndView

[![Build Status](https://travis-ci.org/mushishi78/end_view.svg?branch=master)](https://travis-ci.org/mushishi78/end_view)
[![Gem Version](https://badge.fury.io/rb/end_view.svg)](http://badge.fury.io/rb/end_view)

View model and template in same file using the [tilt gem](https://github.com/rtomayko/tilt).

## Usage

To use, include a new instance of `EndView`, passing `__File__` into the constructor and put the template at the bottom of the file after `__END__`.

``` ruby
require 'end_view'

class Foo
  include EndView.new(__FILE__)

  def my_method
    'Hello World'
  end
end

Foo.new.render # <h1>Hello World</h1>

__END__

%h1= my_method
```

Alternatively, an instance of `EndView` can be extended:

``` ruby
module Baz
  extend EndView.new(__FILE__)

  def self.my_method
    'Howdy World'
  end
end

Baz.render # <h3>Howdy World</h3>

__END__

%h3= my_method
```

### Template Engine

By default Tilt's Haml template engine is used, but alternative engines can be passed in:

``` ruby
require 'tilt/erb'

class Ham
  include EndView.new(__FILE__, Tilt::ERBTemplate)

  def my_method
    'Heya'
  end
end

Ham.new.render # <h1>Heya</h1>

__END__

<h1><%= my_method %></h1>
```

To change the default engine:

``` ruby
EndView.default_engine = Tilt::LiquidTemplate
```

### Layouts

For template engines that support it, view models can be passed blocks:

``` ruby
module MyLayout
  extend EndView.new(__FILE__)
end

MyLayout.render { "S'up" } # <html>S'up</html>

__END__

%html
  = yield
```

These can then be used as layouts:

``` ruby
class Fizz
  include EndView.new(__FILE__)
  self.layout = MyLayout
end

Fizz.new.render # <html><h1>Goodbye</h1></html>

__END__

%h1 Goodbye
```

For layouts that need to be dynamically initialized, `self.layout` can be passed a lambda:

``` ruby
class MyDynamicLayout
  include EndView.new(__FILE__)

  def initialize(title)
    @title = title
  end
end

__END__

%html
  %h1= @title
  = yield
```

``` ruby
class Whizz
  include EndView.new(__FILE__)
  self.layout = -> { MyDynamicLayout.new('Hallo') }
end

Whizz.new.render # <html> <h1>Hallo</h1> <p>Bonjour</p> </html>

__END__

%p Bonjour
```

### Inheritance

Templates are inherited from parent view models:

``` ruby
class Bar < Foo
  def my_method
    'Porridge'
  end
end

Bar.new.render # <h1>Porridge</h1>
```

To override an inherited template, call the `compile` class method:

``` ruby
class Pop < Foo
  compile(__FILE__)
end

Pop.new.render # <p class="inherited">Hello World</p>

__END__

%p.inherited= my_method
```

### locals

Locals can be passed into the render method that override the view models:

``` ruby
Foo.new.render(my_method: 'Stranger') # <h1>Stranger</h1>
```

## Installation

Add your Gemfile:

```ruby
gem 'end_view'
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/end_view/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
