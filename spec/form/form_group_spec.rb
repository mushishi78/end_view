require 'end_view/form/form_group'

module EndView
  module Form
    describe FormGroup do
      let(:rendered) { Form.form_group(attribute) }
      let(:attribute) { Form.attribute(:first_name, opts) }
      let(:opts) { {} }

      context 'with no options' do
        it 'renders' do
          expect(rendered).to have_tag('div') do
            with_tag 'label', text: 'First name'
            with_tag 'input', with: { type: 'text' }
          end
        end
      end

      context 'with no label' do
        let(:opts) { { label: false } }
        it { expect(rendered).to_not have_tag('label') }
      end

      context 'with required' do
        let(:opts) { { required: true } }
        it { expect(rendered).to have_tag('span.required', text: '*') }
      end

      context 'with select' do
        let(:attribute) { Form.select_attribute(:month) }
        it do
          expect(rendered).to have_tag('select') do
            with_tag 'option', with: { value: 0 }, text: 'January'
            with_tag 'option', with: { value: 11 }, text: 'December'
          end
        end
      end
    end
  end
end
