# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Sources
      class Base < ::Avm::EacRailsBase1::Sources::Base
        DEFAULT_TEST_COMMANDS = {}.freeze
        DEFAULT_RUBY_VERSION_PARSER = /ruby_version='([^']+)'/.to_parser { |m| m[1] }
        INSTALLER_PLUGIN_DEFAULT_SETTINGS_PATH =
          'plugins/redmine_installer/installer/default_settings.sh'
        REDMINE_LIB_SUBPATH = 'lib/redmine.rb'
        SUBS_INCLUDE_PATHS_DEFAULT = ['plugins/*'].freeze

        # @return [Avm::VersionNumber]
        def default_ruby_version
          ::Avm::VersionNumber.new(
            DEFAULT_RUBY_VERSION_PARSER.parse!(
              path.join(INSTALLER_PLUGIN_DEFAULT_SETTINGS_PATH).read
            )
          )
        end

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
