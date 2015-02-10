require 'end_view'
require_relative 'my_layout'

class Fizz
  include EndView
  layout MyLayout
end

__END__

%h1 Goodbye
