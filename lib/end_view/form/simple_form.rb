require 'end_view'
require_relative 'form_group'
require_relative 'record_builder'

module EndView
  module Form
    def self.simple_form(*args, &b)
      SimpleForm.render(*args, &b)
    end

    class SimpleForm
      include EndView

      def self.render(*args, &b)
        new(*args).render(&b)
      end

      attr_init :url_or_record, :auth_token, :'opts = {}' do
        @attributes = opts.delete(:attributes) || []
      end

      def render(*args, &b)
        instance_exec(&b) if b
        super(*args)
      end

      def attribute(*args)
        attributes << form_builder.attribute(*args)
      end

      def select_attribute(*args, &b)
        attributes << form_builder.select_attribute(*args, &b)
      end

      attr_reader :attributes

      private

      def form_group(attribute)
        Form.form_group(attribute)
      end

      def form_builder
        @form_builder ||= Form.builder(url_or_record, auth_token, opts)
      end
      alias_method :f, :form_builder

      def button_opts
        opts[:button_opts] || { type: 'submit' }
      end

      def button_value
        opts[:button_value] || 'Okay'
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
    = form_group(attribute)
  %button{button_opts}= button_value
