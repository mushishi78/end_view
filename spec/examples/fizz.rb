require 'end_view'
require_relative 'my_layout'

class Fizz
  include EndView.new(__FILE__)
  self.layout = MyLayout

  private

  def my_method
    'World'
  end
end

__END__

Goodbye <%= my_method %>
