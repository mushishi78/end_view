require 'end_view'
require 'inflecto'
require 'forwardable'
require 'end_view/form/record_builder'

module EndView
  module Form
    class SimpleForm
      include EndView.new(__FILE__)
      extend Forwardable

      attr_method :render, :url_or_record, :auth_token, :attributes, builder_opts: {}

      private

      def_delegators :form_builder, :form_opts,
                                    :auth_token_opts,
                                    :form_method_opts,
                                    :label_opts,
                                    :input_opts

      def form_builder
        @form_builder ||= Form.builder(url_or_record, auth_token, builder_opts)
      end

      def label(attribute)
        Inflecto.humanize(attribute.to_s)
      end
    end
  end
end

__END__

%form{form_opts}
  %input{auth_token_opts}
  %input{form_method_opts}
  - @attributes.each do |attribute|
    .form-group
      %label{label_opts(attribute)}= label(attribute)
      %input{input_opts(attribute)}/
  %button{type: 'submit'} Okay
