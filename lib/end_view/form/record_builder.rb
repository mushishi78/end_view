require 'inflecto'
require 'end_view/form/builder'

module EndView
  module Form
    def self.builder(obj, *args)
      builder_class = obj.is_a?(String) ? Builder : RecordBuilder
      builder_class.new(obj, *args)
    end

    class RecordBuilder < Builder
      attr_init :record, :auth_token, model_name: nil,
                                      model_id: nil,
                                      action: nil,
                                      form_method: nil,
                                      form_url: nil

      def form_opts(opts = {})
        super.merge(class: form_class, id: form_id).merge(opts)
      end

      def input_opts(attribute, opts = {})
        super.merge(value: attribute_value(attribute)).merge(opts)
      end

      private

      def model_name
        @model_name ||= Inflecto.underscore(Inflecto.demodulize(record.class.to_s))
      end

      def model_id
        @model_id ||= ((record.respond_to?(:to_key) && record.to_key) || []).first
      end

      def action
        @action ||= model_id ? 'edit' : 'new'
      end

      def form_method
        @form_method ||= model_id ? 'patch' : 'post'
      end

      def form_url
        @form_url ||= "/#{Inflecto.pluralize(model_name)}/#{model_id}"
      end

      def form_class
        @form_class ||= "#{action}_#{model_name}"
      end

      def form_id
        @form_id ||= [action, model_name, model_id].compact.join('_')
      end

      def attribute_id(attribute)
        "#{model_name}_#{attribute}"
      end

      def attribute_name(attribute)
        "#{model_name}[#{attribute}]"
      end

      def attribute_value(attribute)
        (record.respond_to?(attribute) && record.send(attribute)) || nil
      end
    end
  end
end