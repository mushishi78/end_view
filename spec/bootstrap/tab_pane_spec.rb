require 'end_view/bootstrap'

module EndView
  module Bootstrap
    describe TabPane do
      subject { TabPane.new('my_pane', content: content, label: label, &block) }
      let(:content) { 'My Content' }
      let(:label) { nil }
      let(:block) { -> { 'Content Block' } }

      describe '#render' do
        context 'with content' do
          it { expect(subject.render).to eq(content) }
        end

        context 'with no content but with a block' do
          let(:content) { nil }
          it { expect(subject.render).to eq('Content Block') }
        end

        context 'with no content or block' do
          let(:content) { nil }
          let(:block) { nil }
          it { expect { subject.render }.to raise_error }
        end
      end

      describe '#label' do
        context 'with no label' do
          it 'uses a humanized id' do
            expect(subject.label).to eq('My pane')
          end
        end

        context 'with a label' do
          let(:label) { 'My label' }
          it { expect(subject.label).to eq('My label') }
        end
      end

      describe '#active' do
        it 'is falsey if @active is' do
          expect(subject.active).to be_falsey
        end

        it 'returns "active" if @active is truthy' do
          subject.active = true
          expect(subject.active).to eq('active')
        end
      end
    end
  end
end
