require 'end_view'
require 'attire'

module EndView
  module Rails
    def self.layout(*args, &b)
      Layout.render(*args, &b)
    end

    class Layout
      include EndView

      def self.render(*args, &b)
        new(*args).render(&b)
      end

      attr_init :view_context, title: nil,
                               stylesheet_file: 'application',
                               javascript_file: 'application',
                               head: nil

      private

      alias_method :vc, :view_context

      def stylesheet_args
        [stylesheet_file, { media: 'all', 'data-turbolinks-track' => true }]
      end

      def javascript_args
        [javascript_file, { 'data-turbolinks-track' => true }]
      end
    end
  end
end

__END__

!!! 5
%html
  %head
    - if title
      %title= title
    = vc.stylesheet_link_tag(*stylesheet_args)
    = vc.javascript_include_tag(*javascript_args)
    = vc.csrf_meta_tags
    = head
  %body= yield
