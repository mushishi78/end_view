require 'end_view/form'

module EndView
  module Bootstrap
    describe SimpleForm do
      let(:rendered) { SimpleForm.render(double, 'my_token', [:first_name, :email]) }

      let(:builder) do
        double(form_opts: { class: 'my_form_opts' },
               auth_token_opts: { class: 'my_auth_token_opts' },
               form_method_opts: { class: 'my_form_method_opts' })
      end

      before do
        allow(EndView).to receive(:form_builder).and_return(builder)
        allow(FormGroup).to receive(:render)
          .with(builder, :first_name).and_return('<first_name />')
        allow(FormGroup).to receive(:render)
          .with(builder, :email).and_return('<email />')
      end

      it 'renders' do
        expect(rendered).to have_tag('form.my_form_opts') do
          with_tag 'input.my_auth_token_opts'
          with_tag 'input.my_form_method_opts'
          with_tag 'first_name'
          with_tag 'email'
          with_tag 'button', with: { type: 'submit' }
        end
      end
    end
  end
end
