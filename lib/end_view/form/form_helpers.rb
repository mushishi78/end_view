module EndView
  module FormHelpers
    def form_opts(opts = {})
      { action: url, method: 'post' }.merge(opts)
    end

    def authenticity_token_opts(opts = {})
      { name: 'authenticity_token',
        type: 'hidden',
        value: form_authenticity_token }.merge(opts)
    end

    def patch_opts(opts = {})
      { name: '_method', type: 'hidden', value: 'patch' }.merge(opts)
    end
  end
end
