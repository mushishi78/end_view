require 'end_view'

Dir[File.join(__FILE__, '..', 'examples', '*.rb')].each { |f| require f }

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
