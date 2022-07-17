# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs/command'

module Avm
  module Sources
    class Base
      module Testing
        DEFAULT_TEST_COMMANDS = {}.freeze
        TEST_KEY = 'test'
        TEST_COMMAND_KEY = "#{TEST_KEY}.command"
        TEST_COMMANDS_KEY = "#{TEST_KEY}.commands"

        def configured_test_command
          read_configuration_as_env_command(TEST_COMMAND_KEY)
        end

        # @return [Hash<String, EacRubyUtils::Envs::Command>, nil]
        def configured_test_commands
          configured_value_as_test_commands(configuration.entry(TEST_COMMANDS_KEY).value)
        end

        # @return [Hash<String, EacRubyUtils::Envs::Command>, nil]
        def configured_value_as_test_commands(value)
          return nil if value.blank?

          [::EacRubyUtils::Envs::Command, ::Hash, ::Enumerable].each do |type|
            next unless value.is_a?(type)

            return send(
              "configured_#{type.name.demodulize.variableize}_value_as_test_commands",
              value
            )
          end

          raise "Value for test commands should be a Hash or a Enumerable (Actual: #{value})"
        end

        # @return [Hash<String, EacRubyUtils::Envs::Command>]
        def default_test_commands
          DEFAULT_TEST_COMMANDS
        end

        # @return [Enumerable<EacRubyUtils::Envs::Command>]
        def test_commands
          configured_test_commands ||
            configured_value_as_test_commands(configured_test_command)
          default_test_commands
        end

        protected

        def configured_command_value_as_test_commands(value)
          configured_enumerable_value_as_test_commands([value])
        end

        def configured_enumerable_value_as_test_commands(value)
          configured_hash_value_as_test_commands(
            value.each_with_index.map { |v| ["test_#{v[1]}", v[0]] }.to_h
          )
        end

        def configured_hash_value_as_test_commands(value)
          value.map { |k, v| [k.to_s.strip, configuration_value_to_env_command(v)] }.to_h
        end
      end
    end
  end
end
