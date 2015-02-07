require 'end_view/bootstrap'
require 'rspec-html-matchers'

module EndView
  describe BootstrapFormModal do
    subject { BootstrapFormModal.new('myModal', 'Modal title', form_builder) }
    let(:form_builder) do
      double(form_opts: { class: 'my_form' },
             authenticity_token_opts: { class: 'my_token' },
             form_method_opts: { class: 'my_form_method' })
    end
    let(:rendered) { subject.render { 'content' } }

    it 'renders' do
      expect(rendered).to have_tag('form.my_form') do
        with_tag 'input.my_token'
        with_tag 'input.my_form_method'
        with_tag 'button.btn-default', text: 'Cancel'
        with_tag 'button.btn-primary', with: { type: 'submit' }, text: 'Okay'
      end
    end
  end
end
