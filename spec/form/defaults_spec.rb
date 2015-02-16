require 'end_view/form/defaults'

module EndView
  module Form
    describe Defaults do
      it 'gets email defaults' do
        opts = { control_opts: { type: 'email' } }
        expect(Defaults.default(:my_email_address)).to eq(opts)
      end

      it 'gets phone defaults' do
        opts = { control_opts: { type: 'tel' } }
        expect(Defaults.default(:phone_number)).to eq(opts)
      end

      it 'gets password defaults' do
        opts = { control_opts: { type: 'password' }, required: true }
        expect(Defaults.default(:password_confirmation)).to eq(opts)
      end

      it 'gets url defaults' do
        opts = { control_opts: { type: 'url' } }
        expect(Defaults.default(:site_url)).to eq(opts)
      end

      it 'gets search defaults' do
        opts = { control_opts: { type: 'search', placeholder: 'Search' } }
        expect(Defaults.default(:search)).to eq(opts)
      end

      it 'gets day defaults' do
        default_options = Defaults.default(:expiry_day)[:select_options]
        expect(default_options[0]).to eq(text: 1, opts: { value: 1 })
        expect(default_options[30]).to eq(text: 31, opts: { value: 31 })
      end

      it 'gets month defaults' do
        default_options = Defaults.default(:release_month)[:select_options]
        expect(default_options[0]).to eq(text: 'January', opts: { value: 0 })
        expect(default_options[11]).to eq(text: 'December', opts: { value: 11 })
      end

      it 'gets year defaults' do
        default_options = Defaults.default(:year)[:select_options]
        current_year = Date.today.year
        start_year = current_year - 50
        expect(default_options[0]).to eq(text: start_year, opts: { value: start_year })
        expect(default_options[50]).to eq(text: current_year, opts: { value: current_year })
      end

      it 'gets card defaults' do
        opts = { control_opts: { pattern: '[0-9]{13,16}', autocomplete: 'off' },
                 required: true }
        expect(Defaults.default(:credit_card)).to eq(opts)
      end

      %w(security_code csc cvd cvn cvv cvc ccv spc).each do |name|
        it "gets #{name} defaults" do
          opts = { control_opts: { size: 5, autocomplete: 'off' },
                   required: true }
          expect(Defaults.default(name)).to eq(opts)
        end
      end
    end
  end
end
