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
    'World'
  end
end

Foo.new.render # Hello World

__END__

Hello <%= my_method %>
```

Alternatively, an instance of `EndView` can be extended:

``` ruby
module Baz
  extend EndView.new(__FILE__)

  def self.my_method
    'World'
  end
end

Baz.render # Howdy World

__END__

Howdy <%= my_method %>
```

### Layouts

For template engines that support it, view models can passed blocks:

``` ruby
module MyLayout
  extend EndView.new(__FILE__)
end

MyLayout.render { "S'up" } # <html>S'up</html>

__END__

<html><%= yield %></html>
```

These can then be used as layouts:

``` ruby
class Fizz
  include EndView.new(__FILE__)
  self.layout = MyLayout

  def my_method
    'World'
  end
end

Fizz.new.render # <html>Goodbye World</html>

__END__

Goodbye <%= my_method %>
```

### Inheritance

Templates are inherited:

``` ruby
class Bar < Foo
  def my_method
    'Porridge'
  end
end

Bar.new.render # Hello Porridge
```

To override an inherited template, call the `compile` class method:

``` ruby
class Pop < Foo
  compile(__FILE__)
end

Pop.new.render # The World is too big!

__END__

The <%= my_method %> is too big!
```

### Template Engine

By default Tilt's ERB template engine is used, but alternative engines can be passed in:

``` ruby
require 'tilt/haml'

class Ham
  include EndView.new(__FILE__, Tilt::HamlTemplate)

  def my_method
    'Heya'
  end
end

Ham.new.render # <h1>Heya</h1>

__END__

%h1= my_method
```

To change the default engine:

``` ruby
EndView.default_engine = Tilt::LiquidTemplate
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
