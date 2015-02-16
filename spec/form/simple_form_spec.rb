require 'end_view/form/simple_form'

module EndView
  module Form
    describe SimpleForm do
      let(:rendered) do
        Form.simple_form('/my_url', 'my_token', form_method: 'patch') do
          attribute :customer_name
          attribute :customer_email, required: true
          select_attribute :profession do
            option 'Pick a profession...'
            option 'Teacher', value: 0
            option 'Banker', value: 1
            option 'Nurse', value: 2
          end
        end
      end

      it 'renders' do
        expect(rendered).to have_tag('form', with: { action: '/my_url' }) do
          with_tag 'input', with: { name: 'authenticity_token', value: 'my_token' }
          with_tag 'input', with: { name: '_method', value: 'patch' }

          with_tag 'label', text: 'Customer name'
          with_tag 'input#customer_name', with: { type: 'text' }

          with_tag 'label', text: 'Customer email'
          with_tag 'input#customer_email', with: { type: 'email' }

          with_tag 'label', text: 'Profession'
          with_tag 'select#profession'
          with_tag 'option', text: 'Pick a profession...'
          with_tag 'option', text: 'Teacher', with: { value: 0 }
          with_tag 'option', text: 'Banker', with: { value: 1 }
          with_tag 'option', text: 'Nurse', with: { value: 2 }

          with_tag 'button', with: { type: 'submit' }
        end
      end
    end
  end
end
