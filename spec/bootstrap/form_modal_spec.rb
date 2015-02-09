require 'end_view/bootstrap'
require 'rspec-html-matchers'

module EndView
  module Bootstrap
    describe FormModal do
      let(:rendered) { FormModal.render('myModal', form_builder) { 'content' } }

      let(:form_builder) do
        double(form_opts: { class: 'my_form' },
               auth_token_opts: { class: 'my_token' },
               form_method_opts: { class: 'my_form_method' })
      end

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
end
