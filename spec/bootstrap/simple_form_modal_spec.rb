require 'end_view/bootstrap'

module EndView
  module Bootstrap
    describe SimpleFormModal do
      let(:rendered) do
        SimpleFormModal.render('myModal', record, 'my_token', attributes)
      end
      let(:attributes) { [:email, :password] }
      let(:record) { double(class: 'MyProject::Session') }

      it 'renders' do
        expect(rendered).to have_tag('form', with: { action: '/sessions/' }) do
          with_tag 'input#session_email'
          with_tag 'input#session_password'
        end
      end
    end
  end
end
