require 'end_view'

module EndView
  module Form
    def self.form_group(*args)
      FormGroup.render(*args)
    end

    class FormGroup
      include EndView
      attr_method :render, :attribute
      alias_method :a, :attribute

      private

      def group_opts
        {}
      end

      def control(&b)
        haml_tag(a.control_tag, a.control_opts, &b)
      end
    end
  end
end

__END__

/ Form Group
%div{group_opts}
  - if a.label
    %label{a.label_opts}= a.label_text
  - if a.required
    %span.required *
  - control do
    - a.select_options.each do |option|
      %option{option[:opts]}= option[:text]
