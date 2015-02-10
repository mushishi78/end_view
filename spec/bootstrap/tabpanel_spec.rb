require 'end_view/bootstrap'
require 'rspec-html-matchers'

module EndView
  module Bootstrap
    describe Tabpanel do
      subject { Tabpanel.new(opts) }
      let(:opts) { nil }

      describe '#add_pane' do
        it 'creates a new pane and appends it to panes' do
          subject.add_pane('home') { 'Home content' }
          expect(subject.panes.count).to eq(1)
          expect(subject.panes.first.id).to eq('home')
        end
      end

      describe '#render' do
        before do
          subject.add_pane('home') { 'Home content' }
          subject.add_pane('profile') { 'Profile content' }
          subject.add_pane('messages') { 'Messages content' }
          subject.add_pane('settings') { 'Settings content' }
        end

        def link_opts(id)
          { href: "##{id}", 'aria-controls' => id }
        end

        it 'renders' do
          expect(subject.render).to have_tag('div', with: { role: 'tabpanel' }) do
            with_tag 'ul.nav.nav-tabs', with: { role: 'tablist' }
            with_tag 'li', with: { role: 'presentation' }, count: 4
            with_tag 'li.active', count: 1
            with_tag 'a', with: { 'data-toggle' => 'tab', role: 'tab' }, count: 4
            with_tag 'a', with: link_opts('home'), text: 'Home'
            with_tag 'a', with: link_opts('profile'), text: 'Profile'
            with_tag 'a', with: link_opts('messages'), text: 'Messages'
            with_tag 'a', with: link_opts('settings'), text: 'Settings'
            with_tag '.tab-content'
            with_tag '.tab-pane', with: { role: 'tabpanel' }, count: 4
            with_tag '.tab-pane#home.active', text: 'Home content'
            with_tag '.tab-pane#profile', text: 'Profile content'
            with_tag '.tab-pane#messages', text: 'Messages content'
            with_tag '.tab-pane#settings', text: 'Settings content'
          end
        end

        context 'with opts' do
          let(:opts) { { id: 'my_panel', fade: true, active_pane: 2 } }

          it 'renders' do
            expect(subject.render).to have_tag('div#my_panel') do
              with_tag '.tab-pane#home.fade'
              with_tag '.tab-pane#profile.fade'
              with_tag '.tab-pane#messages.fade.in.active'
              with_tag '.tab-pane#settings.fade'
            end
          end
        end
      end
    end
  end
end
