require 'end_view/rails_layout'

module EndView
	describe RailsLayout do
		subject { RailsLayout.new(view_context, 'My Title') }
		let(:view_context) { double() }
		let(:output) do
			"<!DOCTYPE html>\n" \
      "<html>\n" \
      "  <head>\n" \
      "    <title>My Title</title>\n" \
      "    stylesheet\n" \
      "    javascript\n" \
      "    csrf\n" \
      "  </head>\n" \
      "  <body>content</body>\n" \
      "</html>\n"
		end

		before do
			allow(view_context).to receive(:stylesheet_link_tag)
				.and_return('stylesheet')
			allow(view_context).to receive(:javascript_include_tag)
				.and_return('javascript')
			allow(view_context).to receive(:csrf_meta_tags)
				.and_return('csrf')
		end

		it 'renders a standard layout' do
			expect(subject.render { 'content' }).to eq(output)
		end
	end
end
