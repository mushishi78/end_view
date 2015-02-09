require 'end_view'

module MyLayout
  extend EndView.new(__FILE__)
end

__END__

%html
  = yield
