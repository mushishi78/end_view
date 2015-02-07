module EndView
  module FormHelpers
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

    def form_method
      'post'
    end
  end
end
