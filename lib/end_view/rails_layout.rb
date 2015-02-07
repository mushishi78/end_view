require 'end_view'
require 'haml'
require 'tilt/haml'
require 'forwardable'

module EndView
  class RailsLayout
    include EndView.new(__FILE__, Tilt::HamlTemplate)
    extend Forwardable

    def initialize(view_context, title)
      @view_context, @title = view_context, title
    end

    private

    attr_reader :view_context, :title
    def_delegators :view_context, :stylesheet_link_tag,
                   :javascript_include_tag,
                   :csrf_meta_tags

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
    %title= title
    = stylesheet_link_tag(*stylesheet_args)
    = javascript_include_tag(*javascript_args)
    = csrf_meta_tags
  %body= yield
