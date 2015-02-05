require 'end_view/bootstrap_modal'

module EndView
  describe BootstrapModal do
    subject { BootstrapModal.new('myModal', 'Modal title', opts) }

    context 'with no opts' do
      let(:opts) { {} }
      let(:output) do
        "<div aria-hidden aria-labelledby='myModalLabel' class='fade modal'"\
        " id='myModal' role='dialog' tabindex='-1'>\n" \
        "  <div class='modal-dialog'>\n" \
        "    <div class='modal-content'>\n" \
        "      <div class='modal-header'>\n" \
        "        <button aria-hidden aria-label='Close' class='close'"\
                  " data-dismiss='modal'>\n" \
        "          <span aria-hidden='true'>&times;</span>\n" \
        "        </button>\n" \
        "        <h4 class='modal-title' id='myModalLabel'>Modal title</h4>\n" \
        "      </div>\n" \
        "      <div class='modal-body'>content</div>\n" \
        "      <div class='modal-footer'>\n" \
        "        <button class='btn btn-primary' data-dismiss='modal'>"\
                 "Cancel</button>\n" \
        "      </div>\n" \
        "    </div>\n" \
        "  </div>\n" \
        "</div>\n"
      end

      it 'renders output' do
        expect(subject.render { 'content' }).to eq(output)
      end
    end

    context 'with opts' do
      let(:opts) do
        { size: 'modal-lg',
          cancel: 'No thanks.',
          success: 'Lets do it!',
          success_id: 'success-button' }
      end

      let(:output) do
        "<div aria-hidden aria-labelledby='myModalLabel' class='fade modal'"\
        " id='myModal' role='dialog' tabindex='-1'>\n" \
        "  <div class='modal-dialog modal-lg'>\n" \
        "    <div class='modal-content'>\n" \
        "      <div class='modal-header'>\n" \
        "        <button aria-hidden aria-label='Close' class='close'"\
                  " data-dismiss='modal'>\n" \
        "          <span aria-hidden='true'>&times;</span>\n" \
        "        </button>\n" \
        "        <h4 class='modal-title' id='myModalLabel'>Modal title</h4>\n" \
        "      </div>\n" \
        "      <div class='modal-body'>content</div>\n" \
        "      <div class='modal-footer'>\n" \
        "        <button class='btn btn-default' data-dismiss='modal'>"\
                 "No thanks.</button>\n" \
        "        <button class='btn btn-primary' id='success-button'>"\
                 "Lets do it!</button>\n" \
        "      </div>\n" \
        "    </div>\n" \
        "  </div>\n" \
        "</div>\n"
      end

      it 'renders output' do
        expect(subject.render { 'content' }).to eq(output)
      end
    end
  end
end
