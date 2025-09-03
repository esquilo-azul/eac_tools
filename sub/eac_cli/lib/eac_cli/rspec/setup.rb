# frozen_string_literal: true

module EacCli
  module Rspec
    module Setup
      def disable_input_request
        disable_config_input_request
        disable_speaker_input_request
      end

      def disable_config_input_request
        rspec_config.before do
          # Fixes EacCli::Config::Entry does not implement #input_value error
          ::EacCli::Config::Entry.define_method(:input_value) do
            super
          end
          allow_any_instance_of(::EacCli::Config::Entry).to receive(:input_value) do |obj|
            raise "Console input requested for entry (Path: #{obj.path})"
          end
        end
      end

      def disable_speaker_input_request
        ::RSpec.configure do |config|
          config.around do |example|
            ::EacRubyUtils::Speaker
              .context.on(::EacCli::Speaker.new(in_in: FailIfRequestInput.new)) { example.run }
          end
        end
      end

      class FailIfRequestInput
        %w[gets noecho].each do |method|
          define_method(method) do
            raise "Input method requested: #{method}. Should not request input on RSpec."
          end
        end
      end
    end
  end
end
