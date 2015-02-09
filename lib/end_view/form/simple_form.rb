require 'end_view'
require 'inflecto'
require 'end_view/form/record_builder'

module EndView
  module Form
    class SimpleForm
      include EndView.new(__FILE__)

      attr_method :render, :url_or_record, :auth_token, :attributes, builder_opts: {}

      private

      def f
        @f ||= Form.builder(url_or_record, auth_token, builder_opts)
      end

      def label(attribute)
        Inflecto.humanize(attribute.to_s)
      end
    end
  end
end

__END__

%form{f.form_opts}
  %input{f.auth_token_opts}
  %input{f.form_method_opts}
  - @attributes.each do |attribute|
    .form-group
      %label{f.label_opts(attribute)}= label(attribute)
      %input{f.input_opts(attribute)}/
  %button{type: 'submit'} Okay
