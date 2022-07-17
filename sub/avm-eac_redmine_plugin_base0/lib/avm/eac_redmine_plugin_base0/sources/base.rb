# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        DEFAULT_GEMFILE_PATH = 'SelfGemfile'
        RUBOCOP_TEST_NAME = 'rubocop'
        PARENT_RAKE_TASK_TEST_NAME = 'parent_rake_task'
        INIT_SUBPATH = 'init.rb'

        # @return [String]
        def default_gemfile_path
          DEFAULT_GEMFILE_PATH
        end

        # @return [Hash<String, EacRubyUtils::Envs::Command>]
        def default_test_commands
          {
            PARENT_RAKE_TASK_TEST_NAME => parent_rake_test_command,
            RUBOCOP_TEST_NAME => rubocop_test_command
          }
        end

        # @return [String]
        def init_path
          path.join(INIT_SUBPATH)
        end

        # @return [String]
        def parent_rake_test_task_name
          [gem_name, 'test'].map(&:variableize).join(':')
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
        def valid?
          init_path.exist?
        end
      end
    end
  end
end
