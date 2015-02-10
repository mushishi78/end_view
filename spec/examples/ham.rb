require 'end_view'
require 'tilt/erb'

class Ham
  include EndView.new(template_engine: Tilt::ERBTemplate)

  def my_method
    'Heya'
  end
end

__END__

<h1><%= my_method %></h1>
