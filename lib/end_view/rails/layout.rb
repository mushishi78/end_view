require 'end_view'
require 'forwardable'
require 'attire'

module EndView
  def self.rails_layout(*args)
    Rails::Layout.new(*args)
  end

  module Rails
    class Layout
      include EndView.new(__FILE__)
      extend Forwardable
      attr_init :view_context, :title

      private

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
