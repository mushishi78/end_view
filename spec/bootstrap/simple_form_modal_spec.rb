require 'end_view/bootstrap/simple_form_modal'

module EndView
  module Bootstrap
    describe SimpleFormModal do
      let(:rendered) do
        Bootstrap.simple_form_modal('myModal', '/my_url', 'my_token') do
          attribute :age
          attribute :height, right: 'ft'
          select_attribute :gender do
            option 'Female', value: 'f'
            option 'Male', value: 'm'
          end
        end
      end

      it 'renders' do
        expect(rendered).to have_tag('form') do
          with_tag '.modal#myModal'
          with_tag 'input#age'
          with_tag 'input#height'
          with_tag '.input-group-addon', text: 'ft'
          with_tag 'select#gender'
          with_tag 'option', text: 'Female', with: { value: 'f' }
          with_tag 'option', text: 'Male', with: { value: 'm' }
          with_tag 'button.btn-default', text: 'Cancel', with: { 'data-dismiss' => 'modal' }
          with_tag 'button.btn-primary', text: 'Okay', with: { type: 'submit' }
        end
      end
    end
  end
end
