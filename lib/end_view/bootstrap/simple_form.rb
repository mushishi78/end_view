require 'end_view'
require 'attire'
require 'forwardable'
require 'end_view/bootstrap/form_group'
require 'end_view/form/record_builder'

module EndView
  module Bootstrap
    class SimpleForm
      include EndView.new(__FILE__)
      extend Forwardable

      attr_method :render, :url_or_record, :auth_token, :attributes, builder_opts: {}

      private

      def_delegators :form_builder, :form_opts,
                                    :auth_token_opts,
                                    :form_method_opts

      def form_builder
        @form_builder ||= Form.builder(url_or_record, auth_token, builder_opts)
      end

      def form_group(attribute)
        FormGroup.render(form_builder, attribute)
      end
    end
  end
end

__END__

%form{form_opts}
  %input{auth_token_opts}
  %input{form_method_opts}
  - @attributes.each do |attribute|
    = form_group(attribute)
  %button{type: 'submit'} Okay
