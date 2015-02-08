require 'end_view'
require 'haml'
require 'tilt/haml'
require 'attire'
require 'inflecto'

module EndView
  class BootstrapFormGroup
    include EndView.new(__FILE__, Tilt::HamlTemplate)
    attr_init :form_builder, :attribute, required: false, label: nil, addon: nil

    private

    def label
      @label ||= Inflecto.humanize(attribute.to_s)
    end

    def input_opts
      form_builder.input_opts(attribute)
    end

    def label_opts
      form_builder.label_opts(attribute)
    end
  end
end

__END__

.form-group
  %label{label_opts}= label
  - if required
    %span.required *
  - if addon
    .input-group
      .input-group-addon= addon
      %input.form-control{input_opts}/
  - else
    %input.form-control{input_opts}/
