require 'tilt'

class EndView < Module
  class << self
    attr_writer :default_engine

    def default_engine
      @default_engine ||= Tilt::ERBTemplate
    end
  end

  def initialize(file, template_engine = EndView.default_engine)
    define_singleton_method(:included) do |base|
      base.extend ClassMethods
      base.compile(file, template_engine)
      base.send(:include, RenderMethod)
      base.send(:include, InstanceMethods)
    end

    define_singleton_method(:extended) do |base|
      base.extend ClassMethods
      base.compile(file, template_engine)
      base.extend RenderMethod
    end
  end

  module ClassMethods
    def inherited(child)
      child.template = template
      child.layout = layout
    end

    def compile(file, template_engine = EndView.default_engine)
      @template = template_engine.new { data(file) }
    end

    attr_accessor :layout, :template

    private

    def data(file)
      IO.read(file).gsub("\r\n", "\n").split(/^__END__$/)[1]
    end
  end

  module RenderMethod
    def render(&b)
      rendered_template = template.render(self, &b)
      layout ? layout.render { rendered_template } : rendered_template
    end
  end

  module InstanceMethods
    def layout
      self.class.layout
    end

    def template
      self.class.template
    end
  end
end
