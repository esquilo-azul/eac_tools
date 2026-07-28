# frozen_string_literal: true

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        require_sub __FILE__, include_modules: true

        DEFAULT_GEMFILE_PATH = 'SelfGemfile'

        # @return [String]
        def default_gemfile_path
          DEFAULT_GEMFILE_PATH
        end

        # @return [Hash<String, EacRubyUtils::Envs::Command>]
        def default_test_commands
          r = {}
          r[PARENT_RAKE_TASK_TEST_NAME] = parent_rake_test_command if parent_rake_test_command?
          r[RUBOCOP_TEST_NAME] = rubocop_test_command if rubocop_test_command?
          r
        end

        # @return [Boolean]
        def valid?
          init_path.exist?
        end
      end
    end
  end
end
