require 'end_view'

class Foo
  include EndView

  def my_method
    'Hello World'
  end
end

__END__

%h1= my_method
