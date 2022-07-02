# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacCli
  class Definition
    class PositionalArgument
      DEFAULT_REQUIRED = true
      DEFAULT_VISIBLE = true

      enable_listable
      lists.add_symbol :option, :optional, :repeat, :required, :subcommand, :visible
      common_constructor :name, :options, default: [{}] do
        options.assert_valid_keys(self.class.lists.option.values)
      end

      def build_value(new_value, previous_value)
        if previous_value.is_a?(::Array)
          previous_value + [new_value]
        else
          new_value
        end
      end

      def default_value
        repeat? ? [] : nil
      end

      def identifier
        name.to_s.variableize.to_sym
      end

      def optional?
        !required?
      end

      def repeat?
        options[OPTION_REPEAT]
      end

      def required?
        return true if options.key?(OPTION_REQUIRED) && options.fetch(OPTION_REQUIRED)
        return false if options.key?(OPTION_OPTIONAL) && options.fetch(OPTION_OPTIONAL)

        DEFAULT_REQUIRED
      end

      def subcommand?
        options[OPTION_SUBCOMMAND]
      end

      def to_s
        "#{self.class.name.demodulize}[#{identifier}]"
      end

      def visible?
        options.key?(OPTION_VISIBLE) ? options.fetch(OPTION_VISIBLE) : DEFAULT_VISIBLE
      end
    end
  end
end
