require 'end_view/form_helpers'

module EndView
  describe FormHelpers do
    subject { Class.new { extend FormHelpers } }

    before do
      allow(subject).to receive(:url).and_return('my_url')
      allow(subject).to receive(:form_authenticity_token).and_return('my_token')
    end

    it 'returns form_opts' do
      expect(subject.form_opts).to eq(action: 'my_url', method: 'post')
    end

    it 'return authenticity_token_opts' do
      expect(subject.authenticity_token_opts).to eq(name: 'authenticity_token',
                                                    type: 'hidden',
                                                    value: 'my_token')
    end

    it 'return patch_opts' do
      expect(subject.patch_opts).to eq(name: '_method',
                                       type: 'hidden',
                                       value: 'patch')
    end
  end
end
