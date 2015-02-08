require 'end_view/bootstrap/bootstrap_form_modal'
require 'end_view/form/form_for'
require 'end_view/bootstrap/bootstrap_form_group'

module EndView
  class BootstrapLoginModal
    include EndView.new(__FILE__, Tilt::HamlTemplate)
    self.layout = -> { BootstrapFormModal.new(form_builder, modal_opts) }
    attr_init :user, :form_authenticty_token, form_opts: {}, modal_opts: {}

    private

    def form_builder
      @form_builder ||= FormFor.new(user, form_authenticty_token, form_opts)
    end

    def form_group(attribute, addon = nil)
      BootstrapFormGroup.new(form_builder, attribute, addon: addon).render
    end
  end
end

__END__

= form_group(:email, '@')
= form_group(:password)