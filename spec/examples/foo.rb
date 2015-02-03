require 'end_view'

class Foo
  include EndView.new(__FILE__)

  private

  def my_method
    'World'
  end
end

__END__

Hello <%= my_method %>
