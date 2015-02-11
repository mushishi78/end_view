require 'end_view'

%w(bar baz fizz foo ham pop whizz).each do |example|
  require_relative "examples/#{example}"
end

describe EndView do
  it 'renders a simple template' do
    expect(Foo.new.render).to have_tag('h1', text: 'Hello World')
  end

  it 'renders an inherited template' do
    expect(Bar.new.render).to have_tag('h1', text: 'Porridge')
  end

  it 'renders from singleton' do
    expect(Baz.render).to have_tag('h3', text: 'Howdy World')
  end

  it 'can use a layout' do
    expect(Fizz.new.render).to have_tag('html') do
      with_tag 'h1', text: 'Goodbye'
    end
  end

  it 'uses supplied template engine' do
    expect(Ham.new.render).to have_tag('h1', text: 'Heya')
  end

  it 'can override an inherited template' do
    expect(Pop.new.render).to have_tag('p.inherited', text: 'Hello World')
  end

  it 'accepts locals passed in that override' do
    expect(Foo.new.render(my_method: 'Stranger')).to have_tag('h1', text: 'Stranger')
  end

  it 'can use a dynamic layout' do
    expect(Whizz.new.render).to have_tag('html') do
      with_tag 'h1', text: 'Hallo'
      with_tag 'p', text: 'Bonjour'
    end
  end
end
