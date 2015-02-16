require 'end_view/form/simple_form'
require_relative 'form_group'
require_relative 'record_builder'

module EndView
  module Bootstrap
    def self.simple_form(*args, &b)
      SimpleForm.render(*args, &b)
    end

    class SimpleForm < Form::SimpleForm
      private

      def form_group(attribute)
        Bootstrap.form_group(attribute)
      end

      def form_builder
        @form_builder ||= Bootstrap.builder(url_or_record, auth_token, opts)
      end
    end
  end
end
