require 'end_view/bootstrap/attribute'

module EndView
  module Bootstrap
    describe Attribute do
      subject { Bootstrap.attribute(:email_address) }

      it 'uses bootstrap defaults and handles addon' do
        expect(subject.control_opts).to eq(type: 'email')
        expect(subject.left).to have_tag('span.glyphicon-envelope')
        expect(subject.addon?).to be_truthy
      end
    end
  end
end
