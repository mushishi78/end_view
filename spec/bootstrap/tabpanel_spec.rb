require 'end_view/bootstrap/tabpanel'

module EndView
  module Bootstrap
    describe Tabpanel do
      let(:rendered) do
        Bootstrap.tabpanel(opts) do
          pane('home') { 'Home content' }
          pane('profile') { 'Profile content' }
          pane('messages') { 'Messages content' }
          pane('settings') { 'Settings content' }
        end
      end

      context 'with no opts' do
        let(:opts) { nil }

        def link_opts(id)
          { href: "##{id}", 'aria-controls' => id }
        end

        it 'renders' do
          expect(rendered).to have_tag('div', with: { role: 'tabpanel' }) do
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
      end

      context 'with opts' do
        let(:opts) { { id: 'my_panel', fade: true, active_pane: 2 } }

        it 'renders' do
          expect(rendered).to have_tag('div#my_panel') do
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
