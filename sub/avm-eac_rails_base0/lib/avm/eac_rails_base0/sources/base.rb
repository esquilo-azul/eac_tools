# frozen_string_literal: true

require 'avm/eac_rails_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase0
    module Sources
      class Base < ::Avm::EacRailsBase1::Sources::Base
        CONFIG_RU_SUBPATH = 'config.ru'
        EAC_RAILS_BASE0_TEST_NAME = 'eac_rails_base0'
        EAC_RAILS_BASE0_TEST_RAKE_TASK_NAME = 'eac_rails_base0:test'
        SUBS_INCLUDE_PATHS_DEFAULT = ['sub/*/*'].freeze

        def config_ru_path
          path.join(CONFIG_RU_SUBPATH)
        end

        def default_test_commands
          {
            EAC_RAILS_BASE0_TEST_NAME => eac_rails_base0_test_command
          }
        end

        def eac_rails_base0_test_command
          rake_test_command(EAC_RAILS_BASE0_TEST_RAKE_TASK_NAME)
        end

        def subs_include_paths_default
          SUBS_PATHS_DEFAULT
        end

        def valid?
          super && config_ru_path.exist?
        end
      end
    end
  end
end
