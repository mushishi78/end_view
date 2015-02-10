require 'end_view'

module Baz
  extend EndView

  def self.my_method
    'Howdy World'
  end
end

__END__

%h3= my_method
