require 'end_view'

module Baz
  extend EndView.new(__FILE__)

  private

  def my_method
    'World'
  end
end

__END__

Howdy <%= my_method %>
