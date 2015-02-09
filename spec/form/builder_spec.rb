require 'end_view/form'

module EndView
  module Form
    describe Builder do
      let!(:builder) { Builder.new('my_url', 'my_token', form_method: 'my_method') }

      describe '#form_opts' do
        it { expect(builder.form_opts).to eq(action: 'my_url', method: 'post') }
      end

      describe '#authenticity_token_opts' do
        let(:opts) { { name: 'authenticity_token', type: 'hidden', value: 'my_token' } }
        it { expect(builder.authenticity_token_opts).to eq(opts) }
      end

      describe '#form_method_opts' do
        let(:opts) { { name: '_method', type: 'hidden', value: 'my_method' } }
        it { expect(builder.form_method_opts).to eq(opts) }
      end

      describe '#label_opts' do
        it { expect(builder.label_opts(:firstname)).to eq(for: 'firstname') }
      end

      describe '#input_opts' do
        let(:opts) { { id: 'firstname', name: 'firstname', type: 'text' } }
        it { expect(builder.input_opts(:firstname)).to eq(opts) }

        it { expect(builder.input_opts(:my_email)).to include(type: 'email') }
        it { expect(builder.input_opts(:phone)).to include(type: 'tel') }
        it { expect(builder.input_opts(:password)).to include(type: 'password') }
        it { expect(builder.input_opts(:url)).to include(type: 'url') }
        it { expect(builder.input_opts(:search)).to include(type: 'search', placeholder: 'Search') }
        it { expect(builder.input_opts(:card)).to include(pattern: '[0-9]{13,16}', autocomplete: 'off') }

        [:security_code, :csc, :cvd, :cvn, :cvv, :cvc, :ccv, :spc].each do |input|
          it { expect(builder.input_opts(input)).to include(size: 5, autocomplete: 'off') }
        end
      end
    end
  end
end
