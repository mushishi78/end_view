require 'end_view/form/record_builder'
require_relative 'builder'

module EndView
  module Bootstrap
    def self.builder(url_or_record, *args)
      builder_class = url_or_record.is_a?(String) ? Builder : RecordBuilder
      builder_class.new(url_or_record, *args)
    end

    class RecordBuilder < Form::RecordBuilder
      def attribute(name, opts = {})
        Bootstrap.attribute(name, attribute_opts(name, opts))
      end

      def select_attribute(name, opts = {}, &b)
        Bootstrap.select_attribute(name, attribute_opts(name, opts), &b)
      end
    end
  end
end
