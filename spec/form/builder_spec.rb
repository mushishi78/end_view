require 'end_view/form/builder'

module EndView
  module Form
    describe Builder do
      let!(:builder) { Form.builder('my_url', 'my_token', form_method: 'my_method') }

      describe '#form_opts' do
        it { expect(builder.form_opts).to eq(action: 'my_url', method: 'post') }
      end

      describe '#auth_token_opts' do
        let(:opts) { { name: 'authenticity_token', type: 'hidden', value: 'my_token' } }
        it { expect(builder.auth_token_opts).to eq(opts) }
      end

      describe '#form_method_opts' do
        let(:opts) { { name: '_method', type: 'hidden', value: 'my_method' } }
        it { expect(builder.form_method_opts).to eq(opts) }
      end

      describe '#label_opts' do
        it { expect(builder.label_opts(:firstname)).to eq(for: 'firstname') }
      end

      describe '#control_opts' do
        let(:opts) { { id: 'firstname', name: 'firstname' } }
        it { expect(builder.control_opts(:firstname)).to eq(opts) }
      end

      describe '#attribute_opts' do
        let(:opts) do
          { control_opts: { id: 'firstname', name: 'firstname' },
            label_opts: { for: 'firstname' } }
        end
        it { expect(builder.attribute_opts(:firstname)).to eq(opts) }
      end
    end
  end
end
