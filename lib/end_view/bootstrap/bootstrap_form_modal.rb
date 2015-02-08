require 'end_view/bootstrap/bootstrap_modal'
require 'forwardable'

module EndView
  class BootstrapFormModal < BootstrapModal
    compile(__FILE__, Tilt::HamlTemplate)
    extend Forwardable

    def initialize(id, title, form_builder, opts = {})
      opts[:dismiss_value] ||= 'Cancel'
      super(id, title, opts)
      @form_builder = form_builder
      @submit_value = opts[:submit_value] || 'Okay'
    end

    private

    attr_reader :form_builder, :submit_value
    def_delegators :form_builder, :form_opts,
                   :authenticity_token_opts,
                   :form_method_opts

    def submit_opts
      { class: 'btn btn-primary', type: 'submit' }
    end
  end
end

__END__

.modal{modal_opts}
  .modal-dialog{dialog_opts}
    .modal-content
      .modal-header
        %button{close_opts}
          %span(aria-hidden) &times;
        %h4{title_opts}= @title
      %form{form_opts}
        %input{authenticity_token_opts}
        %input{form_method_opts}
        .modal-body= yield
        .modal-footer
          %button{dismiss_opts}= dismiss_value
          %button{submit_opts}= submit_value