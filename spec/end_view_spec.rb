require 'end_view'
require_relative 'examples/foo'
require_relative 'examples/bar'
require_relative 'examples/baz'
require_relative 'examples/fizz'

describe EndView do
  it 'renders a simple template' do
    expect(Foo.new.render).to eq("\n\nHello World\n")
  end

  it 'renders an inherited template' do
    expect(Bar.new.render).to eq("\n\nHello Porridge\n")
  end

  it 'renders from singleton' do
    expect(Baz.render).to eq("\n\nHowdy World\n")
  end

  it 'overrides an inherited template' do
    expect(Fizz.new.render).to eq("\n\n<html>\n\nGoodbye World\n</html>\n")
  end
end
