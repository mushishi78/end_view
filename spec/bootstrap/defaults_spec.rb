require 'end_view/bootstrap/defaults'

module EndView
  module Bootstrap
    describe Defaults do
      it 'email default has envelope icon addon' do
        default = Defaults.default(:customer_email)
        expect(default[:control_opts]).to eq(type: 'email')
        expect(default[:left]).to have_tag('span.glyphicon-envelope')
      end

      it 'phone default has earphone icon addon' do
        default = Defaults.default(:telephone)
        expect(default[:control_opts]).to eq(type: 'tel')
        expect(default[:left]).to have_tag('span.glyphicon-earphone')
      end

      it 'password default has lock icon addon' do
        default = Defaults.default(:password)
        expect(default[:control_opts]).to eq(type: 'password')
        expect(default[:left]).to have_tag('span.glyphicon-lock')
      end

      it 'card default has credit card icon addon' do
        default = Defaults.default(:card_number)
        expect(default[:control_opts]).to include(pattern: '[0-9]{13,16}')
        expect(default[:left]).to have_tag('span.glyphicon-credit-card')
      end
    end
  end
end
