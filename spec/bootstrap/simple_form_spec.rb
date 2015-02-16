require 'end_view/bootstrap/simple_form'

module EndView
  module Bootstrap
    describe SimpleForm do
      let(:rendered) do
        Bootstrap.simple_form('/my_url', 'my_token') do
          attribute :email
          attribute :password
        end
      end

      it 'renders' do
        expect(rendered).to have_tag('.form-group') do
          with_tag '.input-group'
          with_tag '.input-group-addon'
          with_tag 'span.glyphicon-envelope'
          with_tag 'input.form-control#email'
        end
        expect(rendered).to have_tag('.form-group') do
          with_tag '.input-group'
          with_tag '.input-group-addon'
          with_tag 'span.glyphicon-lock'
          with_tag 'input.form-control#password'
        end
      end
    end
  end
end
