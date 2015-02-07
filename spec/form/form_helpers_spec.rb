require 'end_view/form'

module EndView
  describe FormHelpers do
    subject { Class.new { extend FormHelpers } }

    before do
      allow(subject).to receive(:form_url).and_return('my_url')
      allow(subject).to receive(:form_authenticity_token).and_return('my_token')
      allow(subject).to receive(:form_method).and_return('my_method')
    end

    it 'returns form_opts' do
      expect(subject.form_opts).to eq(action: 'my_url', method: 'post')
    end

    it 'return authenticity_token_opts' do
      expect(subject.authenticity_token_opts).to eq(name: 'authenticity_token',
                                                    type: 'hidden',
                                                    value: 'my_token')
    end

    it 'return form_method_opts' do
      expect(subject.form_method_opts).to eq(name: '_method',
                                             type: 'hidden',
                                             value: 'my_method')
    end
  end
end
