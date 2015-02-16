require 'end_view/form/builder'
require_relative 'attribute'

module EndView
  module Bootstrap
    def self.builder(*args)
      Builder.new(*args)
    end

    class Builder < Form::Builder
      def attribute(name, opts = {})
        Bootstrap.attribute(name, attribute_opts(name, opts))
      end

      def select_attribute(name, opts = {}, &b)
        Bootstrap.select_attribute(name, attribute_opts(name, opts), &b)
      end
    end
  end
end
