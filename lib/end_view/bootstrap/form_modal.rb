require 'end_view/bootstrap/modal'

module EndView
  module Bootstrap
    class FormModal
      include EndView.new(__FILE__)

      def self.render(*args, &b)
        new(*args).render(&b)
      end

      attr_init :modal_id, :form_builder, :'opts = {}'

      def render(&b)
        super { Modal.render(modal_id, opts_with_buttons, &b) }
      end

      private

      alias_method :f, :form_builder

      def opts_with_buttons
        { buttons: buttons }.merge(@opts)
      end

      def cancel_value
        opts[:cancel_value] || 'Cancel'
      end

      def submit_value
        opts[:submit_value] || 'Okay'
      end

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