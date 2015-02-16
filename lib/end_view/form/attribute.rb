require 'attire'
require 'inflecto'
require_relative 'defaults'

module EndView
  module Form
    class Attribute
      class << self
        alias_method :attribute, :new

        def select_attribute(name, opts = {}, &b)
          opts[:control_tag] ||= :select
          opts[:control_opts] ||= {}
          opts[:control_opts][:type] ||= nil
          new(name, opts, &b)
        end
      end

      def initialize(name, opts = {}, &b)
        @name = name
        assign_from_hash(base)
        assign_from_hash(default) unless opts.delete(:ignore_defaults)
        assign_from_hash(opts)
        instance_exec(&b) if b
      end

      attr_accessor :name, :required, :label, :label_text, :label_opts,
                    :control_tag, :control_opts, :select_options

      def option(text, opts = {})
        select_options << { text: text, opts: opts }
      end

      private

      def default
        Defaults.default(name)
      end

      def base
        { control_tag: :input,
          required: false,
          label: true,
          label_text: Inflecto.humanize(name.to_s),
          label_opts: {},
          control_opts: { type: 'text' },
          select_options: [] }
      end

      def assign_from_hash(hash)
        hash.each do |k, v|
          current = send(k)
          send("#{k}=", current.is_a?(Hash) ? current.merge(v) : v)
        end
      end
    end

    class << self
      extend Forwardable
      def_delegators Attribute, :attribute, :select_attribute
    end
  end
end
