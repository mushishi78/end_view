require 'end_view/bootstrap/modal'

module EndView
  module Bootstrap
    describe Modal do
      let(:rendered) { Bootstrap.modal('myModal', opts) { 'content' } }

      context 'with opts' do
        let(:opts) do
          { title: 'Modal title', size: 'modal-lg', label: 'myLabel' }
        end

        let(:modal_opts) { { tabindex: -1, role: 'dialog', 'aria-labelledby' => 'myLabel' } }
        let(:close_opts) { { 'aria-label' => 'Close', 'data-dismiss' => 'modal' } }
        let(:dissmiss_opts) { { with: { 'data-dismiss' => 'modal' }, text: 'Okay' } }

        it 'renders' do
          expect(rendered).to have_tag('.modal.fade#myModal', with: modal_opts) do
            with_tag '.modal-dialog.modal-lg'
            with_tag '.modal-content'
            with_tag '.modal-header'
            with_tag 'button.close', with: close_opts
            with_tag 'h4.modal-title#myLabel', text: 'Modal title'
            with_tag '.modal-body', text: 'content'
            with_tag '.modal-footer'
            with_tag 'button.btn.btn-default', dissmiss_opts
          end
        end
      end

      context 'without opts' do
        let(:opts) { {} }

        it 'doesnt render header without title' do
          expect(rendered).to_not have_tag('.modal-header')
        end
      end
    end
  end
end
