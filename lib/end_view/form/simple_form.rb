require 'end_view'
require 'inflecto'
require 'end_view/form/record_builder'

module EndView
  module Form
    def self.simple_form(*args)
      SimpleForm.render(*args)
    end

    class SimpleForm
      include EndView
      attr_method :render, :url_or_record, :auth_token, :attributes, :'opts = {}'

      private

      def form_builder
        @form_builder ||= Form.builder(url_or_record, auth_token, opts)
      end
      alias_method :f, :form_builder

      def label(attribute)
        Inflecto.humanize(attribute.to_s)
      end
    end
  end
end

__END__

/ Simple Form
%form{f.form_opts}
  %input{f.auth_token_opts}
  %input{f.form_method_opts}
  - attributes.each do |attribute|
    .form-group
      %label{f.label_opts(attribute)}= label(attribute)
      %input{f.input_opts(attribute)}/
  %button{type: 'submit'} Okay
