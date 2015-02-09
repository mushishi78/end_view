require 'attire'

module EndView
  module Form
    class Builder
      attr_init :form_url, :form_authenticity_token, form_method: 'post'

      def form_opts(opts = {})
        { action: form_url, method: 'post' }.merge(opts)
      end

      def authenticity_token_opts(opts = {})
        { name: 'authenticity_token',
          type: 'hidden',
          value: form_authenticity_token }.merge(opts)
      end

      def form_method_opts(opts = {})
        { name: '_method', type: 'hidden', value: form_method }.merge(opts)
      end

      def label_opts(attribute, opts = {})
        { for: attribute_id(attribute) }.merge(opts)
      end

      def input_opts(attribute, opts = {})
        { id: attribute_id(attribute),
          name: attribute_name(attribute),
          type: 'text' }.merge(find_default(attribute)).merge(opts)
      end

      private

      def attribute_id(attribute)
        attribute.to_s
      end

      def attribute_name(attribute)
        attribute.to_s
      end

      def input_defaults
        @input_defaults ||= {
          %w(email)    => { type: 'email' },
          %w(phone)    => { type: 'tel' },
          %w(password) => { type: 'password' },
          %w(url)      => { type: 'url' },
          %w(search)   => { type: 'search', placeholder: 'Search' },
          %w(card)     => { pattern: '[0-9]{13,16}', autocomplete: 'off' },
          %w(security_code csc cvd cvn cvv cvc ccv spc) => { size: 5, autocomplete: 'off' }
        }
      end

      def find_default(attribute)
        input_defaults.each { |k, v| return v if k.any? { |w| attribute =~ /#{w}/ } }
        {}
      end
    end
  end
end
