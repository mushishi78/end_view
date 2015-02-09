require_relative 'foo'

class Pop < Foo
  compile(__FILE__)
end

__END__

%p.inherited= my_method
