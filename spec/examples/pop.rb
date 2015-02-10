require_relative 'foo'

class Pop < Foo
  compile_template
end

__END__

%p.inherited= my_method
