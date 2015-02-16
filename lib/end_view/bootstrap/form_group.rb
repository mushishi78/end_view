require 'end_view/form/form_group'

module EndView
  module Bootstrap
    def self.form_group(*args)
      FormGroup.render(*args)
    end

    class FormGroup < Form::FormGroup
      private

      def group_opts
        { class: 'form-group' }
      end

      def control(&b)
        control_opts = add_class(a.control_opts, 'form-control')
        return haml_tag(a.control_tag, control_opts, &b) unless a.addon?

        haml_tag(:div, class: 'input-group') do
          haml_tag(:div, a.left, class: 'input-group-addon') if a.left
          haml_tag(a.control_tag, control_opts, &b)
          haml_tag(:div, a.right, class: 'input-group-addon') if a.right
        end
      end

      def add_class(opts, klass)
        opts.merge(class: ([opts[:class]].flatten << klass).compact)
      end
    end
  end
end
