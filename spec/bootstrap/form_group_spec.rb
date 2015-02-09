require 'end_view/bootstrap'
require 'rspec-html-matchers'

module EndView
  module Bootstrap
    describe FormGroup do
      let(:rendered) { FormGroup.render(form_builder, attribute, opts) }
      let(:form_builder) do
        double(label_opts: { class: 'my_label' }, input_opts: { class: 'my_input' })
      end
      let(:attribute) { :first_name }
      let(:opts) { {} }

      context 'with no options' do
        it 'renders' do
          expect(rendered).to have_tag('.form-group') do
            with_tag 'label.my_label', text: 'First name'
            with_tag 'input.form-control.my_input'
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

      context 'with addons' do
        let(:opts) { { left: '$', right: '.00' } }
        it 'renders' do
          expect(rendered).to have_tag('.input-group') do
            with_tag '.input-group-addon', text: '$'
            with_tag 'input.form-control.my_input'
            with_tag '.input-group-addon', text: '.00'
          end
        end
      end

      context 'for email default' do
        let(:attribute) { :my_email }
        it 'renders' do
          expect(rendered).to have_tag('.input-group-addon') do
            with_tag 'span.glyphicon.glyphicon-envelope'
          end
        end
      end

      context 'for phone default' do
        let(:attribute) { :phone_number }
        it 'renders' do
          expect(rendered).to have_tag('.input-group-addon') do
            with_tag 'span.glyphicon.glyphicon-earphone'
          end
        end
      end

      context 'for password confirmation default' do
        [:repeat_password, :password_confirmation].each do |attribute|
          let(:attribute) { attribute }
          it 'renders' do
            expect(rendered).to have_tag('.form-group') do
              with_tag 'span.required', text: '*'
              with_tag 'span.glyphicon.glyphicon-repeat'
            end
          end
        end
      end

      context 'for password default' do
        let(:attribute) { :password }
        it 'renders' do
          expect(rendered).to have_tag('.form-group') do
            with_tag 'span.required', text: '*'
            with_tag 'span.glyphicon.glyphicon-lock'
          end
        end
      end

      context 'for card default' do
        let(:attribute) { :credit_card }
        it 'renders' do
          expect(rendered).to have_tag('.form-group') do
            with_tag 'span.required', text: '*'
            with_tag 'span.glyphicon.glyphicon-credit-card'
          end
        end
      end
    end
  end
end
