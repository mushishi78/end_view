require 'end_view'
require 'attire'

module EndView
  def self.rails_layout(*args)
    Rails::Layout.new(*args)
  end

  module Rails
    class Layout
      include EndView
      attr_init :view_context, :title, head: nil

      private

      alias_method :vc, :view_context

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
    = vc.stylesheet_link_tag(*stylesheet_args)
    = vc.javascript_include_tag(*javascript_args)
    = vc.csrf_meta_tags
    = head
  %body= yield
