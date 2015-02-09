require 'end_view/rails'
require 'rspec-html-matchers'

module EndView
  module Rails
    describe Layout do
      let(:rendered) { Layout.new(vc, 'My Title').render { 'content' } }
      let(:vc) { double }

      before do
        allow(vc).to receive(:stylesheet_link_tag).and_return('<stylesheets />')
        allow(vc).to receive(:javascript_include_tag).and_return('<javascripts />')
        allow(vc).to receive(:csrf_meta_tags).and_return('<csrf />')
      end

      it 'renders' do
        expect(rendered).to have_tag('html') do
          with_tag 'head'
          with_tag 'title', text: 'My Title'
          with_tag 'stylesheets'
          with_tag 'javascripts'
          with_tag 'csrf'
          with_tag 'body', text: 'content'
        end
      end
    end
  end
end
