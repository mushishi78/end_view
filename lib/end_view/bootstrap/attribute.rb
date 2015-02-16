require 'end_view/form/attribute'
require_relative 'defaults'

module EndView
  module Bootstrap
    class Attribute < Form::Attribute
      attr_accessor :left, :right

      def addon?
        left || right
      end

      private

      def default
        Bootstrap::Defaults.default(name)
      end
    end

    class << self
      extend Forwardable
      def_delegators Attribute, :attribute, :select_attribute
    end
  end
end
