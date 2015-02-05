require 'end_view'
require 'haml'
require 'tilt/haml'

module EndView
  class BootstrapModal
    include EndView.new(__FILE__, Tilt::HamlTemplate)

    def initialize(id, title, opts = {})
      @id, @title = id, title
      @label = "#{id}Label"
      @size = opts[:size]
      @cancel_value = opts[:cancel] || 'Cancel'
      @success_value = opts[:success]
      @success_id = opts[:success_id]
    end

    private

    def modal_opts
      { id: @id,
        class: 'fade',
        tabindex: -1,
        role: 'dialog',
        aria: { labelledby: @label, hidden: true } }
    end

    def dialog_opts
      { class: @size }
    end

    def close_opts
      { class: 'close',
        'data-dismiss' => 'modal',
        aria: { hidden: true, label: 'Close' } }
    end

    def title_opts
      { class: 'modal-title', id: @label }
    end

    def buttons
      [cancel_button, success_button]
    end

    def cancel_button
      [cancel_opts, @cancel_value]
    end

    def cancel_opts
      { class: ['btn', @success_value ? 'btn-default' : 'btn-primary'],
        'data-dismiss' => :modal }
    end

    def success_button
      [success_opts, @success_value] if @success_value
    end

    def success_opts
      { class: 'btn btn-primary', id: @success_id }
    end
  end
end

__END__

.modal{modal_opts}
  .modal-dialog{dialog_opts}
    .modal-content
      .modal-header
        %button{close_opts}
          %span(aria-hidden="true") &times;
        %h4{title_opts}= @title
      .modal-body= yield
      .modal-footer
        - buttons.compact.each do |(opts, value)|
          %button{opts}= value
