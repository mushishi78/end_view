require 'end_view/form/attribute'

module EndView
  module Form
    describe Attribute do
      subject { Form.attribute(name, opts) }
      let(:name) { :first_name }
      let(:opts) { {} }

      context 'with no options' do
        it do
          expect(subject.name).to eq(:first_name)
          expect(subject.control_tag).to eq(:input)
          expect(subject.required).to be(false)
          expect(subject.label).to be(true)
          expect(subject.label_text).to eq('First name')
          expect(subject.label_opts).to eq({})
          expect(subject.control_opts).to eq(type: 'text')
        end
      end

      context 'with options' do
        let(:opts) do
          { control_tag: :textarea,
            required: true,
            label_opts: { class: 'lbl' },
            control_opts: { type: nil } }
        end

        it do
          expect(subject.control_tag).to eq(:textarea)
          expect(subject.required).to be(true)
          expect(subject.label_opts).to eq(class: 'lbl')
          expect(subject.control_opts).to eq(type: nil)
        end
      end

      describe 'defaults' do
        context 'with a default' do
          let(:name) { :credit_card }

          it 'uses defaults, and merges hashes' do
            ctrl = { type: 'text', pattern: '[0-9]{13,16}', autocomplete: 'off' }
            expect(subject.control_opts).to eq(ctrl)
            expect(subject.required).to be(true)
          end
        end

        context 'with a default and opts' do
          let(:name) { :credit_card }
          let(:opts) { { control_opts: { pattern: nil }, required: false } }

          it 'overrides defaults' do
            expect(subject.control_opts).to include(pattern: nil)
            expect(subject.required).to be(false)
          end
        end

        context 'with ignore defaults option' do
          let(:name) { :credit_card }
          let(:opts) { { ignore_defaults: true } }

          it 'ignores defaults' do
            expect(subject.control_opts).to_not include(pattern: '[0-9]{13,16}')
            expect(subject.required).to be(false)
          end
        end
      end

      describe '.select_attribute' do
        subject do
          Form.select_attribute(:period) do
            option 'Select a time period...'
            option 'Hourly', value: 0
            option 'Weekly', value: 1
            option 'Monthly', value: 2
          end
        end

        it do
          expect(subject.control_tag).to eq(:select)
          expect(subject.control_opts[:type]).to be(nil)
          expect(subject.select_options[0]).to eq(text: 'Select a time period...', opts: {})
          expect(subject.select_options[1]).to eq(text: 'Hourly', opts: { value: 0 })
          expect(subject.select_options[2]).to eq(text: 'Weekly', opts: { value: 1 })
          expect(subject.select_options[3]).to eq(text: 'Monthly', opts: { value: 2 })
        end
      end
    end
  end
end
