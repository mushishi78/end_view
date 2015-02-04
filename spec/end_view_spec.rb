require 'end_view'

require_relative 'examples/bar'
require_relative 'examples/baz'
require_relative 'examples/fizz'
require_relative 'examples/foo'
require_relative 'examples/ham'
require_relative 'examples/my_layout'
require_relative 'examples/pop'

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

  it 'can use a layout' do
    expect(Fizz.new.render).to eq("\n\n<html>\n\nGoodbye World\n</html>\n")
  end

  it 'uses supplied template engine' do
    expect(Ham.new.render).to eq("<h1>Heya</h1>\n")
  end

  it 'can override an inherited template' do
    expect(Pop.new.render).to eq("\n\nThe World is too big!\n")
  end
end
