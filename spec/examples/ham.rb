require 'end_view'
require 'tilt/haml'

class Ham
  include EndView.new(__FILE__, Tilt::HamlTemplate)

  def my_method
    'Heya'
  end
end

__END__

%h1= my_method
