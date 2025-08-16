# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Sources
      class Base < ::Avm::EacRailsBase1::Sources::Base
        DEFAULT_TEST_COMMANDS = {}.freeze
        REDMINE_LIB_SUBPATH = 'lib/redmine.rb'
        SUBS_INCLUDE_PATHS_DEFAULT = ['plugins/*'].freeze

        # Return a empty hash (No tests).
        #
        # @return [Hash<String, EacRubyUtils::Envs::Command].
        def default_test_commands
          DEFAULT_TEST_COMMANDS
        end

        def redmine_lib_path
          path.join(REDMINE_LIB_SUBPATH)
        end

        def subs_include_paths_default
          SUBS_INCLUDE_PATHS_DEFAULT
        end

        def valid?
          super && redmine_lib_path.exist?
        end
      end
    end
  end
end
