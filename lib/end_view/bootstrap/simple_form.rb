require 'end_view'
require 'attire'
require 'end_view/bootstrap/form_group'
require 'end_view/form/record_builder'

module EndView
  def self.bootstrap_simple_form(*args)
    Bootstrap::SimpleForm.render(*args)
  end

  module Bootstrap
    class SimpleForm
      include EndView.new(__FILE__)
      attr_method :render, :url_or_record, :auth_token, :attributes, :'opts = {}'

      private

      def form_builder
        @form_builder ||= EndView.form_builder(url_or_record, auth_token, opts)
      end
      alias_method :f, :form_builder

      def form_group(attribute)
        FormGroup.render(form_builder, attribute)
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
