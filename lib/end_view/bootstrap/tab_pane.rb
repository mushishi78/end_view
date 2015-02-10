require 'attire'
require 'inflecto'

module EndView
  def self.bootstrap_tab_pane(*args, &b)
    Bootstrap::TabPane.new(*args, &b)
  end

  module Bootstrap
    class TabPane
      attr_init :id, { content: nil, label: nil }, :'&content_block'
      public :id
      attr_writer :active

      def render
        content || content_block.call
      end

      def label
        @label ||= Inflecto.humanize(id)
      end

      def active
        @active && 'active'
      end
    end
  end
end
