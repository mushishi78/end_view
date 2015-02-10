require 'attire'
require 'inflecto'

module EndView
  module Bootstrap
    def self.tab_pane(*args, &b)
      TabPane.new(*args, &b)
    end

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
