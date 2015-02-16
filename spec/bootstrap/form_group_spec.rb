# encoding: UTF-8
require 'end_view/bootstrap/form_group'

module EndView
  module Bootstrap
    describe FormGroup do
      let(:rendered) { Bootstrap.form_group(attribute) }
      let(:attribute) { Bootstrap.attribute(:cost, opts) }

      context 'with addons' do
        let(:opts) { { left: '£', right: '.00' } }

        it 'renders addons' do
          expect(rendered).to have_tag('.form-group') do
            with_tag '.input-group'
            with_tag '.input-group-addon', text: '£'
            with_tag 'input.form-control'
            with_tag '.input-group-addon', text: '.00'
          end
        end
      end

      context 'without addons' do
        let(:opts) { {} }

        it 'renders without addons' do
          expect(rendered).to have_tag('.form-group') do
            with_tag 'input.form-control'
            without_tag '.input-group'
            without_tag '.input-group-addon'
          end
        end
      end
    end
  end
end
