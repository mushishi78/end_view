require 'end_view'

module MyLayout
  extend EndView
end

__END__

%html
  = yield
