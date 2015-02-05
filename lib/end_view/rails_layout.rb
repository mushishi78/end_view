require 'delegate'
require 'end_view'
require 'haml'
require 'tilt/haml'

module EndView
  class RailsLayout < SimpleDelegator
    include EndView.new(__FILE__, Tilt::HamlTemplate)

    def initialize(view_context, title)
      super(view_context)
      @title = title
    end

    private

    def stylesheet_args
      ['application', { media: 'all', 'data-turbolinks-track' => true }]
    end

    def javascript_args
      ['application', { 'data-turbolinks-track' => true }]
    end
  end
end

__END__

!!! 5
%html
  %head
    %title= @title
    = stylesheet_link_tag{stylesheet_args}
    = javascript_include_tag{javascript_args}
    = csrf_meta_tags
  %body= yield