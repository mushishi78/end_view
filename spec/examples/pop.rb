require_relative 'foo'

class Pop < Foo
  compile(__FILE__)
end

__END__

The <%= my_method %> is too big!
