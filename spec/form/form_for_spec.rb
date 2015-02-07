require 'end_view/form'

module EndView
  describe FormFor do
    subject { FormFor.new(record, 'my_token') }

    context 'with a new record' do
      let(:record) { double(class: 'MyProject::User', firstname: nil) }

      it 'returns form_opts' do
        expect(subject.form_opts).to eq(action: '/users/',
                                        class: 'new_user',
                                        id: 'new_user',
                                        method: 'post')
      end

      it 'returns label_opts' do
        expect(subject.label_opts(:firstname)).to eq(for: 'user_firstname')
      end

      it 'returns input_opts' do
        expect(subject.input_opts(:firstname)).to eq(id: 'user_firstname',
                                                     name: 'user[firstname]',
                                                     type: 'text',
                                                     value: nil)
      end
    end

    context 'with an old record' do
      let(:record) do
        double(class: 'MyProject::User', to_key: [3], firstname: 'Harry')
      end

      it 'returns form_opts' do
        expect(subject.form_opts).to eq(action: '/users/3',
                                        class: 'edit_user',
                                        id: 'edit_user_3',
                                        method: 'post')
      end

      it 'returns label_opts' do
        expect(subject.label_opts(:firstname)).to eq(for: 'user_firstname')
      end

      it 'returns input_opts' do
        expect(subject.input_opts(:firstname)).to eq(id: 'user_firstname',
                                                     name: 'user[firstname]',
                                                     type: 'text',
                                                     value: 'Harry')
      end
    end
  end
end
