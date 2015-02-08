require 'end_view/bootstrap'
require 'rspec-html-matchers'

module EndView
  describe BootstrapFormGroup do
    subject do
      BootstrapFormGroup.new(form_builder, :first_name, required: required,
                                                        addon: addon)
    end
    let(:rendered) { subject.render { 'content' } }
    let(:required) { nil }
    let(:addon) { nil }

    let(:form_builder) do
      double(label_opts: { class: 'my_label' },
             input_opts: { class: 'my_input' })
    end

    context 'with no options' do
      it 'renders' do
        expect(rendered).to have_tag('.form-group') do
          with_tag 'label.my_label', text: 'First name'
          with_tag 'input.form-control.my_input'
        end
      end
    end

    context 'with required' do
      let(:required) { true }
      it { expect(rendered).to have_tag('span.required', text: '*') }
    end

    context 'with addon' do
      let(:addon) { '@' }
      it 'renders' do
        expect(rendered).to have_tag('.input-group') do
          with_tag '.input-group-addon', text: '@'
          with_tag 'input.form-control.my_input'
        end
      end
    end
  end
end
