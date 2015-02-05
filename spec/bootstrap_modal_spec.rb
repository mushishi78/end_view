require 'end_view/bootstrap_modal'
require 'rspec-html-matchers'

module EndView
  describe BootstrapModal do
    subject { BootstrapModal.new('myModal', 'Modal title', opts) }
    let(:rendered) { subject.render { 'content' } }

    context 'with no opts' do
      let(:opts) { {} }
      let(:modal_opts) { { tabindex: -1, role: 'dialog', 'aria-labelledby' => 'myModalLabel' } }
      let(:close_opts) { { 'aria-label' => 'Close', 'data-dismiss' => 'modal' } }
      let(:cancel_opts) { { with: { 'data-dismiss' => 'modal' }, text: 'Cancel' } }

      it 'renders' do
        expect(rendered).to have_tag('.modal.fade#myModal', with: modal_opts) do
          with_tag '.modal-dialog'
          with_tag '.modal-content'
          with_tag '.modal-header'
          with_tag 'button.close', with: close_opts
          with_tag 'h4.modal-title#myModalLabel', text: 'Modal title'
          with_tag '.modal-body', text: 'content'
          with_tag '.modal-footer'
          with_tag 'button.btn.btn-primary', cancel_opts
        end
      end
    end

    context 'with opts' do
      let(:opts) do
        { size: 'modal-lg',
          cancel: 'No thanks.',
          success: 'Lets do it!',
          success_id: 'success-button' }
      end
      let(:cancel_opts) { { with: { 'data-dismiss' => 'modal' }, text: 'No thanks.' } }

      it 'renders' do
        expect(rendered).to have_tag('.modal') do
          with_tag '.modal-dialog.modal-lg'
          with_tag 'button.btn.btn-default', cancel_opts
          with_tag 'button.btn.btn-primary#success-button', text: 'Lets do it!'
        end
      end
    end
  end
end
