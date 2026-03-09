# frozen_string_literal: true

require 'rspec'
require 'rubocop'

module EacRubyGemSupport
  module Rspec
    module Specs
      module Rubocop
        def describe_rubocop # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          this = self
          ::RSpec.describe ::RuboCop do
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
      end
    end
  end
end
