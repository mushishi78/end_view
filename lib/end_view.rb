require 'haml'
require 'tilt/haml'

module EndView
  class << self
    attr_writer :default_engine

    def default_engine
      @default_engine ||= Tilt::HamlTemplate
    end

    def included(base, opts = {})
      base.extend ClassMethods
      base.compile_template(opts.merge(start: 4))
      base.send(:include, InstanceMethods)
      base.send(:include, Methods)
    end

    def extended(base, opts = {})
      base.extend ClassMethods
      base.compile_template(opts.merge(start: 4))
      base.extend(Methods)
    end

    def new(opts = {})
      Module.new do
        define_singleton_method(:included) { |base| EndView.included(base, opts) }
        define_singleton_method(:extended) { |base| EndView.extended(base, opts) }
      end
    end
  end

  module ClassMethods
    attr_accessor :template

    def inherited(child)
      super
      child.template = template
      child.layout(retrieve_layout)
    end

    def compile_template(opts = {})
      file = opts[:file] || caller_file(opts[:start] || 3)
      template_engine = opts[:template_engine] || EndView.default_engine
      @template = template_engine.new(file) { data(file) }
    end

    def layout(layout)
      @layout = layout
    end

    def retrieve_layout
      @layout
    end

    private

    def caller_file(start)
      caller(start, 1).first.split(/:\d*:in/).first
    end

    def data(file)
      IO.read(file).gsub("\r\n", "\n").split(/^__END__$/).last
    end
  end

  module Methods
    def render(*args, &b)
      rendered_template = template.render(self, *args, &b)
      layout = retrieve_layout
      layout ? layout.render { rendered_template } : rendered_template
    end
  end

  module InstanceMethods
    def retrieve_layout
      layout = self.class.retrieve_layout
      layout.respond_to?(:call) ? instance_exec(&layout) : layout
    end

    def template
      self.class.template
    end
  end
end
