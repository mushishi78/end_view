require 'date'

module EndView
  module Form
    class Defaults
      class << self
        def default(name)
          defaults.each { |(k, v)| return v if name =~ /#{[k].flatten.join('|')}/ }
          {}
        end

        def defaults
          @defaults ||= [email, phone, password, url, search,
                         day, month, year, card, security_code]
        end

        attr_writer :defaults, :email, :phone, :password, :url,
                    :search, :day, :month, :year, :card, :security_code

        def email
          @email ||= ['email', { control_opts: { type: 'email' } }]
        end

        def phone
          @phone ||= ['phone', { control_opts: { type: 'tel' } }]
        end

        def password
          @password ||= ['password', {
            control_opts: { type: 'password' }, required: true
          }]
        end

        def url
          @url ||= ['url', { control_opts: { type: 'url' } }]
        end

        def search
          @search ||= ['search', {
            control_opts: { type: 'search', placeholder: 'Search' }
          }]
        end

        def day
          @day ||= ['day', { select_options: to_select_options(1..31) }]
        end

        def month
          @month ||= ['month', { select_options: to_select_options(months) }]
        end

        def year
          @year ||= ['year', { select_options: to_select_options(years) }]
        end

        def card
          @card ||= ['card', {
            control_opts: { pattern: '[0-9]{13,16}', autocomplete: 'off' },
            required: true
          }]
        end

        def security_code
          @security_code ||= [%w(security_code csc cvd cvn cvv cvc ccv spc), {
            control_opts: { size: 5, autocomplete: 'off' },
            required: true
          }]
        end

        private

        def to_select_options(array)
          array.each_with_index.map do |el, i|
            { text: el, opts: { value: el.is_a?(Numeric) ? el : i } }
          end
        end

        def months
          %w(January February March April May June
             July August September October November December)
        end

        def years
          current = Date.today.year
          current - 50..current
        end
      end
    end
  end
end
