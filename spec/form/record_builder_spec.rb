require 'end_view/form'

module EndView
  module Form
    describe '.builder' do
      it 'uses Builder for strings' do
        expect(Builder).to receive(:new)
        Form.builder('/users/1', 'my_token')
      end

      it 'uses RecordBuilder for not strings' do
        expect(RecordBuilder).to receive(:new)
        Form.builder(double, 'my_token')
      end
    end

    describe RecordBuilder do
      subject { RecordBuilder.new(record, 'my_token') }

      context 'with a new record' do
        let(:record) { double(class: 'MyProject::User', name: nil) }
        let(:form_opts) { { action: '/users/', class: 'new_user', id: 'new_user' } }
        let(:input_opts) { { id: 'user_name', name: 'user[name]' } }

        describe '#form_opts' do
          it { expect(subject.form_opts).to include(form_opts) }
        end

        describe '#form_method_opts' do
          it { expect(subject.form_method_opts).to include(value: 'post') }
        end

        describe '#label_opts' do
          it { expect(subject.label_opts(:name)).to include(for: 'user_name') }
        end

        describe '#input_opts' do
          it { expect(subject.input_opts(:name)).to include(input_opts) }
        end
      end

      context 'with an old record' do
        let(:record) { double(class: 'MyProject::User', to_key: [3], name: 'Harry') }
        let(:form_opts) { { action: '/users/3', class: 'edit_user', id: 'edit_user_3' } }

        describe '#form_opts' do
          it { expect(subject.form_opts).to include(form_opts) }
        end

        describe '#form_method_opts' do
          it { expect(subject.form_method_opts).to include(value: 'patch') }
        end

        describe '#label_opts' do
          it { expect(subject.label_opts(:name)).to include(for: 'user_name') }
        end

        describe '#input_opts' do
          it { expect(subject.input_opts(:name)).to include(value: 'Harry') }
        end
      end
    end
  end
end
