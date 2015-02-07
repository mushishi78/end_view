require 'end_view/bootstrap'
require 'rspec-html-matchers'

module EndView
  describe BootstrapModal do
    subject { BootstrapModal.new('myModal', 'Modal title', size: 'modal-lg') }
    let(:rendered) { subject.render { 'content' } }

    let(:modal_opts) { { tabindex: -1, role: 'dialog', 'aria-labelledby' => 'myModalLabel' } }
    let(:close_opts) { { 'aria-label' => 'Close', 'data-dismiss' => 'modal' } }
    let(:dissmiss_opts) { { with: { 'data-dismiss' => 'modal' }, text: 'Okay' } }

    it 'renders' do
      expect(rendered).to have_tag('.modal.fade#myModal', with: modal_opts) do
        with_tag '.modal-dialog'
        with_tag '.modal-content'
        with_tag '.modal-header'
        with_tag 'button.close', with: close_opts
        with_tag 'h4.modal-title#myModalLabel', text: 'Modal title'
        with_tag '.modal-body', text: 'content'
        with_tag '.modal-footer'
        with_tag 'button.btn.btn-default', dissmiss_opts
      end
    end
  end
end
