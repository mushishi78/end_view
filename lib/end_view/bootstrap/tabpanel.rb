require 'end_view'
require 'attire'
require 'end_view/bootstrap/tab_pane'

module EndView
  def self.bootstrap_tabpanel(*args)
    Bootstrap::Tabpanel.new(*args)
  end

  module Bootstrap
    class Tabpanel
      include EndView.new(__FILE__)
      attr_init id: nil, panes: [], fade: false, active_pane: 0
      public :panes

      def add_pane(*args, &b)
        panes << TabPane.new(*args, &b)
      end

      def render(*args, &b)
        set_active_pane
        super(*args, &b)
      end

      private

      def set_active_pane
        panes.each { |p| p.active = false }
        panes[active_pane].active = true
      end

      def link_opts(pane)
        { href: "##{pane.id}",
          role: 'tab',
          'aria-controls' => pane.id,
          'data-toggle' => 'tab' }
      end

      def pane_opts(pane)
        { id: pane.id,
          role: 'tabpanel',
          class: [fade && 'fade',
                  fade && pane.active && 'in',
                  pane.active] }
      end
    end
  end
end

__END__

%div{id: id, role: 'tabpanel'}

  / Nav tabs
  %ul.nav.nav-tabs{role: 'tablist'}
    - panes.each do |pane|
      %li{role: 'presentation', class: pane.active}
        %a{link_opts(pane)}= pane.label

  / Tab panes
  .tab-content
    - panes.each do |pane|
      .tab-pane{pane_opts(pane)}= pane.render
