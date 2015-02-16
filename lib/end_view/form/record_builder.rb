require 'inflecto'
require_relative 'builder'

module EndView
  module Form
    def self.builder(url_or_record, *args)
      builder_class = url_or_record.is_a?(String) ? Builder : RecordBuilder
      builder_class.new(url_or_record, *args)
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

      def control_opts(name)
        super.merge(value: control_value(name))
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

      def control_id(attribute_name)
        "#{model_name}_#{attribute_name}"
      end

      def control_name(attribute_name)
        "#{model_name}[#{attribute_name}]"
      end

      def control_value(attribute_name)
        (record.respond_to?(attribute_name) && record.send(attribute_name)) || nil
      end
    end
  end
end
