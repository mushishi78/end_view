require 'end_view'

class MyDynamicLayout
  include EndView.new(__FILE__)

  def initialize(title)
    @title = title
  end
end

__END__

%html
	%h1= @title
	= yield
