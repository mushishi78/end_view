require 'end_view'

class Foo
  include EndView.new(__FILE__)

  def my_method
    'Hello World'
  end
end

__END__

%h1= my_method
