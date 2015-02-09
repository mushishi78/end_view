require 'end_view'
require 'attire'
require 'end_view/bootstrap/form_group'
require 'end_view/form/record_builder'

module EndView
  module Bootstrap
    class SimpleForm
      include EndView.new(__FILE__)

      attr_method :render, :url_or_record, :auth_token, :attributes, builder_opts: {}

      private

      def f
        @f ||= Form.builder(url_or_record, auth_token, builder_opts)
      end

      def form_group(attribute)
        FormGroup.render(f, attribute)
      end
    end
  end
end

__END__

%form{f.form_opts}
  %input{f.auth_token_opts}
  %input{f.form_method_opts}
  - attributes.each do |attribute|
    = form_group(attribute)
  %button{type: 'submit'} Okay
