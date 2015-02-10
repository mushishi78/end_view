require 'end_view/form'

module EndView
  module Form
    describe SimpleForm do
      let(:rendered) { SimpleForm.render(double, 'my_token', [:first_name, :email]) }

      let(:builder) do
        double(form_opts: { class: 'my_form_opts' },
               auth_token_opts: { class: 'my_auth_token_opts' },
               form_method_opts: { class: 'my_form_method_opts' },
               label_opts: { class: 'my_label_opts' },
               input_opts: { class: 'my_input_opts' })
      end

      before do
        allow(EndView).to receive(:form_builder).and_return(builder)
      end

      it 'renders' do
        expect(rendered).to have_tag('form.my_form_opts') do
          with_tag 'input.my_auth_token_opts'
          with_tag 'input.my_form_method_opts'
          with_tag '.form-group', count: 2
          with_tag 'label.my_label_opts', text: 'First name'
          with_tag 'label.my_label_opts', text: 'Email'
          with_tag 'input.my_input_opts', count: 2
          with_tag 'button', with: { type: 'submit' }
        end
      end
    end
  end
end
