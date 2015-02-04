require 'end_view'
require_relative 'my_layout'

class Fizz
  include EndView.new(__FILE__)
  self.layout = MyLayout
end

__END__

Goodbye
