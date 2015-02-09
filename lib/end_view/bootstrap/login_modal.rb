require 'end_view/bootstrap/form_modal'
require 'end_view/bootstrap/form_group'
require 'end_view/form/record_builder'

module EndView
  module Bootstrap
    class LoginModal
      attr_method :render, :user, :form_authenticty_token, form_opts: {},
                                                           modal_opts: {},
                                                           form_builder: nil

      def render
        FormModal.render(form_builder, modal_opts) do
          form_group(:email) << form_group(:password)
        end
      end

      private

      def form_builder
        @form_builder ||=
          Form::RecordBuilder.new(user, form_authenticty_token, form_opts)
      end

      def form_group(attribute)
        FormGroup.render(form_builder, attribute)
      end
    end
  end
end
