require 'end_view/bootstrap/modal'
require 'forwardable'

module EndView
  module Bootstrap
    class FormModal < Modal
      compile(__FILE__)
      extend Forwardable

      def initialize(form_builder, opts = {})
        super({ dismiss_value: 'Cancel' }.merge(opts))
        @form_builder = form_builder
        @submit_value = opts[:submit_value] || 'Okay'
      end

      private

      attr_reader :form_builder, :submit_value
      def_delegators :form_builder, :form_opts,
                                    :auth_token_opts,
                                    :form_method_opts

      def submit_opts
        { class: 'btn btn-primary', type: 'submit' }
      end
    end
  end
end

__END__

.modal{modal_opts}
  .modal-dialog{dialog_opts}
    .modal-content
      - if title
        .modal-header
          %button{close_opts}
            %span(aria-hidden) &times;
          %h4{title_opts}= title
      %form{form_opts}
        %input{auth_token_opts}
        %input{form_method_opts}
        .modal-body= yield
        .modal-footer
          %button{dismiss_opts}= dismiss_value
          %button{submit_opts}= submit_value
