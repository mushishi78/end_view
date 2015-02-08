require 'end_view/bootstrap'
require 'rspec-html-matchers'

module EndView
  describe BootstrapLoginModal do
    subject { BootstrapLoginModal.new(session, 'my_token') }
    let(:session) { double(class: 'MyProject::Session') }

    it 'renders' do
    	expect(subject.render).to have_tag('form', with: { action: '/sessions/' }) do
    		with_tag 'input#session_email'
    		with_tag 'input#session_password'
    	end
    end
  end
end
