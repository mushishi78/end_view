require 'end_view'
require 'attire'

module EndView
  def self.bootstrap_modal(*args, &b)
    Bootstrap::Modal.render(*args, &b)
  end

  module Bootstrap
    class Modal
      include EndView.new(__FILE__)
      attr_init :id, title: nil,
                     size: nil,
                     label: nil,
                     dismiss_value: 'Okay',
                     buttons: nil

      def self.render(*args, &b)
        new(*args).render(&b)
      end

      private

      def modal_opts
        { id: id,
          class: 'fade',
          tabindex: -1,
          role: 'dialog',
          aria: { labelledby: label, hidden: true } }
      end

      def label
        @label ||= "#{id}Label"
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

      def buttons
        @buttons ||= [[dismiss_opts, dismiss_value]]
      end

      def dismiss_opts
        { class: 'btn btn-default', 'data-dismiss' => :modal }
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
      .modal-body= yield
      .modal-footer
        - buttons.each do |(button_opts, button_value)|
          %button{button_opts}= button_value
