require 'end_view'
require_relative 'my_dynamic_layout'

class Whizz
  include EndView
  layout -> { MyDynamicLayout.new(title) }

  def title
    'Hallo'
  end
end

__END__

%p Bonjour
