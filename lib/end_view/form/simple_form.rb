require 'end_view'
require 'inflecto'
require 'delegate'

module EndView
  module Form
    class SimpleForm < SimpleDelegator
      include EndView.new(__FILE__)

      def self.render(*args)
        new(*args).render
      end

      def initialize(obj, auth_token, attributes)
        super(Form.builder(obj, auth_token))
        @attributes = attributes
      end

      private

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
