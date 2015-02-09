require 'end_view/bootstrap/modal'

module EndView
  module Bootstrap
    class FormModal
      include EndView.new(__FILE__)

      def self.render(*args, &b)
        new(*args).render(&b)
      end

      def initialize(f, opts = {})
        @f = f
        @cancel_value = opts[:cancel_value] || 'Cancel'
        @submit_value = opts[:submit_value] || 'Okay'
        @opts = { buttons: buttons }.merge(opts)
      end

      def render(&b)
        super { Modal.render(opts, &b) }
      end

      private

      attr_reader :f, :cancel_value, :submit_value, :opts

      def buttons
        [[cancel_opts, cancel_value], [submit_opts, submit_value]]
      end

      def cancel_opts
        { class: 'btn btn-default', 'data-dismiss' => :modal }
      end

      def submit_opts
        { class: 'btn btn-primary', type: 'submit' }
      end
    end
  end
end

__END__

%form{f.form_opts}
  %input{f.auth_token_opts}
  %input{f.form_method_opts}
  = yield