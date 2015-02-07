require 'end_view'
require 'haml'
require 'tilt/haml'
require 'attire'

module EndView
  class BootstrapModal
    include EndView.new(__FILE__, Tilt::HamlTemplate)
    attr_init :id, :title, size: nil, dismiss_value: 'Okay'

    private

    def modal_opts
      { id: id,
        class: 'fade',
        tabindex: -1,
        role: 'dialog',
        aria: { labelledby: label, hidden: true } }
    end

    def label
      "#{id}Label"
    end

    def dialog_opts
      { class: size }
    end

    def close_opts
      { class: 'close',
        'data-dismiss' => 'modal',
        aria: { hidden: true, label: 'Close' } }
    end

    def title_opts
      { class: 'modal-title', id: label }
    end

    def dismiss_opts
      { class: 'btn btn-default', 'data-dismiss' => :modal }
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
        %h4{title_opts}= title
      .modal-body= yield
      .modal-footer
        %button{dismiss_opts}= dismiss_value
