# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        require_sub __FILE__, include_modules: true

        DEFAULT_GEMFILE_PATH = 'SelfGemfile'
        RUBOCOP_GEM_NAME = 'rubocop'
        RUBOCOP_TEST_NAME = 'rubocop'
        PARENT_RAKE_TASK_TEST_NAME = 'parent_rake_task'

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

        # @return [String]
        def parent_rake_test_task_name
          [gem_name, 'test'].map(&:variableize).join(':')
        end

        # @return [Boolean]
        def parent_rake_test_command?
          ruby_parent.rake_task?(parent_rake_test_task_name)
        end

        # @return [EacRubyUtils::Envs::Command]
        def parent_rake_test_command
          ruby_parent.rake(parent_rake_test_task_name).chdir_root.envvar('RAILS_ENV', 'test')
        end

        # @return [EacRubyUtils::Envs::Command]
        def rubocop_test_command
          bundle('exec', 'rubocop', '--ignore-parent-exclusion')
            .envvar('RAILS_ENV', 'test')
            .chdir_root
        end

        # @return [Boolean]
        def rubocop_test_command?
          gemfile_path.exist? && gemfile_lock_gem_version(RUBOCOP_GEM_NAME).present?
        end

        # @return [Boolean]
        def valid?
          init_path.exist?
        end
      end
    end
  end
end
