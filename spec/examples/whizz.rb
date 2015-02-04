require 'end_view'
require_relative 'my_dynamic_layout'

class Whizz
  include EndView.new(__FILE__)
  self.layout = -> { MyDynamicLayout.new(title) }

  def title
  	'Hallo'
  end
end

__END__

Bonjour
