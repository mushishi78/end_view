require 'end_view'
require 'attire'
require 'inflecto'

module EndView
  def self.bootstrap_form_group(*args)
    Bootstrap::FormGroup.render(*args)
  end

  module Bootstrap
    class FormGroup
      include EndView.new(__FILE__)
      attr_method :render, :form_builder, :attribute, required: false,
                                                      label: nil,
                                                      left: nil,
                                                      right: nil,
                                                      input_opts: {},
                                                      label_opts: {}

      private

      def input_opts
        form_builder.input_opts(attribute, @input_opts)
      end

      def label_opts
        form_builder.label_opts(attribute, @label_opts)
      end

      def label
        @label = default[:label] || Inflecto.humanize(attribute.to_s) if @label.nil?
        @label
      end

      def left
        @left ||= default[:left]
      end

      def right
        @right ||= default[:right]
      end

      def required
        @required ||= default[:required]
      end

      def default
        @default ||= begin
          match = defaults.find { |k, _v| k.any? { |w| attribute =~ /#{w}/ } }
          match ? match[1] : {}
        end
      end

      def defaults
        @defaults ||= {
          %w(email)          => { left: icon('envelope') },
          %w(phone)          => { left: icon('earphone') },
          %w(repeat confirm) => { left: icon('repeat'), required: true },
          %w(password)       => { left: icon('lock'), required: true },
          %w(card)           => { left: icon('credit-card'), required: true }
        }
      end

      def icon(icon)
        "<span class='glyphicon glyphicon-#{icon}' aria-hidden='true'></span>"
      end
    end
  end
end

__END__

/ Bootstrap Form Group
.form-group
  - if label
    %label{label_opts}= label
  - if required
    %span.required *
  - if left || right
    .input-group
      - if left
        .input-group-addon= left
      %input.form-control{input_opts}/
      - if right
        .input-group-addon= right
  - else
    %input.form-control{input_opts}/
