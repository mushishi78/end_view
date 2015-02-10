require 'end_view/bootstrap/form_modal'
require 'end_view/bootstrap/form_group'
require 'end_view/form'

module EndView
  module Bootstrap
    class SimpleFormModal
      attr_method :render, :modal_id,
                           :url_or_record,
                           :auth_token,
                           :attributes,
                           :'form_opts = {}',
                           :'modal_opts= {}'

      def render
        FormModal.render(modal_id, form_builder, modal_opts) do
          attributes.map { |attribute| form_group(attribute) }.join
        end
      end

      private

      def form_builder
        @form_builder ||= Form.builder(url_or_record, auth_token, form_opts)
      end

      def form_group(attribute)
        FormGroup.render(form_builder, attribute)
      end
    end
  end
end
