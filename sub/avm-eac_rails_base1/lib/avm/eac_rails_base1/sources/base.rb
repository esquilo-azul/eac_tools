# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase1
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        CONFIG_RU_SUBPATH = 'config.ru'
        EAC_RAILS_BASE1_TEST_NAME = 'eac_rails_base1'
        RAKE_TEST_COMMAND_DEFAULT_TASK_NAME = 'test'
        SUBS_PATHS_DEFAULT = ['sub/*/*'].freeze

        def config_ru_path
          path.join(CONFIG_RU_SUBPATH)
        end

        def default_test_commands
          {
            EAC_RAILS_BASE1_TEST_NAME => eac_rails_base1_test_command
          }
        end

        def eac_rails_base1_test_command
          rake_test_command
        end

        def rake_test_command(task_name = RAKE_TEST_COMMAND_DEFAULT_TASK_NAME)
          rake(task_name).chdir_root.envvar('RAILS_ENV', 'test')
        end

        def subs_paths_default
          SUBS_PATHS_DEFAULT
        end

        def valid?
          super && config_ru_path.exist?
        end
      end
    end
  end
end
