require_relative 'form_modal'
require_relative 'form_group'
require_relative 'record_builder'

module EndView
  module Bootstrap
    def self.simple_form_modal(*args, &b)
      SimpleFormModal.render(*args, &b)
    end

    class SimpleFormModal
      def self.render(*args, &b)
        new(*args).render(&b)
      end

      attr_init :id, :url_or_record, :auth_token, attributes: [],
                                                  form_opts: {},
                                                  modal_opts: {}

      def render(&b)
        instance_exec(&b) if b
        Bootstrap.form_modal(id, form_builder, modal_opts) do
          attributes.map { |attribute| form_group(attribute) }.join
        end
      end

      def attribute(*args)
        attributes << form_builder.attribute(*args)
      end

      def select_attribute(*args, &b)
        attributes << form_builder.select_attribute(*args, &b)
      end

      attr_reader :attributes

      private

      def form_builder
        @form_builder ||= Bootstrap.builder(url_or_record, auth_token, form_opts)
      end

      def form_group(attribute)
        Bootstrap.form_group(attribute)
      end
    end
  end
end
