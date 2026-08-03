# frozen_string_literal: true

require 'rspec'
require 'rubocop'

module EacRubyGemSupport
  module Rspec
    module Setup
      module Rubocop
        RUN_LAST_METADATA_KEY = :eac_ruby_gem_support_rubocop_check

        def describe_rubocop # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          this = self
          ::RSpec.describe ::RuboCop, RUN_LAST_METADATA_KEY => true do
            before do
              ::RuboCop::ConfigLoader.ignore_parent_exclusion = true
            end

            let(:root_path) { this.app_root_path }
            let(:config_store) do
              r = ::RuboCop::ConfigStore.new
              r.for(root_path)
              r
            end
            let(:runner) { ::RuboCop::Runner.new({}, config_store) }

            it 'rubocop return ok' do
              expect(::Dir.chdir(root_path) { runner.run([]) }).to eq(true)
            end
          end
        end

        # @return [void]
        def setup_rubocop
          setup_rubocop_last
          describe_rubocop unless specific_files_requested?
        end

        # @return [void]
        def setup_rubocop_last
          previous_strategy = ::RSpec.configuration.ordering_registry.fetch(:global)
          ::RSpec.configure do |config|
            config.register_ordering(:global) do |list|
              ordered = previous_strategy.order(list)
              last, others = ordered.partition { |item| item.metadata[RUN_LAST_METADATA_KEY] }
              others + last
            end
          end
        end

        # @return [Boolean]
        def specific_files_requested?
          config = ::RSpec.configuration
          files_or_directories = config.instance_variable_get(:@files_or_directories_to_run)
          default_pattern = ::RSpec::Core::Configuration.new.pattern
          files_or_directories != [config.default_path] || config.pattern != default_pattern
        end
      end
    end
  end
end
