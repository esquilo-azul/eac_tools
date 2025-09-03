# frozen_string_literal: true

require 'active_support/hash_with_indifferent_access'
require 'ostruct'

module EacCli
  class Speaker
    class List
      VALUE_STRUCT = ::Struct.new(:key, :label, :value)

      class << self
        # @param list [Array, Hash]
        # @param options [Hash]
        def build(list, options = {})
          return List.new(hash_to_values(list), options) if list.is_a?(::Hash)
          return List.new(array_to_values(list), options) if list.is_a?(::Array)

          raise "Invalid list: #{list} (#{list.class})"
        end

        private

        def hash_to_values(list)
          list.map { |key, value| VALUE_STRUCT.new(key, key, value) }
        end

        def array_to_values(list)
          list.map { |value| VALUE_STRUCT.new(value, value, value) }
        end
      end

      DEFAULT_IGNORE_CASE = true

      enable_listable
      lists.add_symbol :option, :ignore_case

      # @!attribute [r] values
      #   @return [Array<VALUE_STRUCT>]
      #   # @!attribute [r] options
      #   @return [Hash]
      # @!method initialize(values)
      #   @param values [Array<VALUE_STRUCT>]
      #   @param options [Hash]
      common_constructor :values, :options, default: [{}] do
        self.options = self.class.lists.option.hash_keys_validate!(options)
        self.values = values.map do |v|
          VALUE_STRUCT.new(to_key(v.key), to_label(v.label), v.value)
        end
      end

      # @return [Boolean]
      def ignore_case?
        options.if_key(OPTION_IGNORE_CASE, DEFAULT_IGNORE_CASE, &:to_bool)
      end

      def valid_labels
        values.map(&:label)
      end

      def valid_value?(value)
        values.any? { |v| v.key == to_key(value) }
      end

      # @param value [Object]
      # @return [String]
      def to_key(value)
        r = to_label(value)
        ignore_case? ? r.downcase : r
      end

      def to_label(value)
        value.to_s.strip
      end

      def build_value(value)
        key = to_key(value)
        values.each do |v|
          return v.value if v.key == key
        end
        raise "Value not found: \"#{value}\" (#{values})"
      end
    end
  end
end
