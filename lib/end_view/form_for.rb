require 'inflecto'
require 'end_view/form_helpers'

module EndView
  class FormFor
    include FormHelpers

    def initialize(record, form_authenticity_token, opts = {})
      @record = record
      @form_authenticity_token = form_authenticity_token
      @model_name = opts[:model_name]
      @model_id = opts[:model_id]
      @action = opts[:action]
      @method = opts[:method]
      @url = opts[:url]
    end

    def form_opts(opts = {})
      super.merge(class: form_class, id: form_id).merge(opts)
    end

    def label_opts(attribute, opts = {})
      { for: attribute_id(attribute) }.merge(opts)
    end

    def input_opts(attribute, opts = {})
      { id: attribute_id(attribute),
        name: attribute_name(attribute),
        type: 'text',
        value: record.send(attribute) }.merge(opts)
    end

    attr_accessor :record, :form_authenticity_token
    attr_writer :model_name, :model_id, :action, :method, :url

    def model_name
      @model_name ||= Inflecto.underscore(Inflecto.demodulize(record.class.to_s))
    end

    def model_id
      @model_id ||= (record.respond_to?(:to_key) && record.to_key.first) || nil
    end

    def action
      @action ||= model_id ? :edit : :new
    end

    def url
      @url ||= "/#{Inflecto.pluralize(model_name)}/#{model_id}"
    end

    def form_class
      @form_class ||= "#{action}_#{model_name}"
    end

    def form_id
      @form_id ||= [action, model_name, model_id].compact.join('_')
    end

    def attribute_id(attribute)
      "#{model_name}_#{attribute}"
    end

    def attribute_name(attribute)
      "#{model_name}[#{attribute}]"
    end
  end
end
