require 'attire'
require_relative 'attribute'

module EndView
  module Form
    def self.builder(*args)
      Builder.new(*args)
    end

    class Builder
      attr_init :form_url, :auth_token, form_method: 'post'

      def form_opts(opts = {})
        { action: form_url, method: 'post' }.merge(opts)
      end

      def auth_token_opts(opts = {})
        { name: 'authenticity_token',
          type: 'hidden',
          value: auth_token }.merge(opts)
      end

      def form_method_opts(opts = {})
        { name: '_method', type: 'hidden', value: form_method }.merge(opts)
      end

      def label_opts(name)
        { for: control_id(name) }
      end

      def control_opts(name)
        { id: control_id(name), name: control_name(name) }
      end

      def attribute_opts(name, opts = {})
        { label_opts: label_opts(name),
          control_opts: control_opts(name) }.merge(opts)
      end

      def attribute(name, opts = {})
        Form.attribute(name, attribute_opts(name, opts))
      end

      def select_attribute(name, opts = {}, &b)
        Form.select_attribute(name, attribute_opts(name, opts), &b)
      end

      private

      def control_id(name)
        name.to_s
      end

      def control_name(name)
        name.to_s
      end
    end
  end
end
