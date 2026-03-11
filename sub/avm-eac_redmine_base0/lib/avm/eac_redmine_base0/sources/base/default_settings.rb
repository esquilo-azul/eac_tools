# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Sources
      class Base < ::Avm::EacRailsBase1::Sources::Base
        module DefaultSettings
          common_concern

          DEFAULT_RUBY_VERSION_PARSER = /ruby_version='([^']+)'/.to_parser { |m| m[1] }
          INSTALLER_PLUGIN_DEFAULT_SETTINGS_PATH =
            'plugins/redmine_installer/installer/default_settings.sh'

          # @return [Avm::VersionNumber]
          def default_ruby_version
            ::Avm::VersionNumber.new(default_setting_value(DEFAULT_RUBY_VERSION_PARSER))
          end

          # @param parser [EacRubyUtils::RegexpParser]
          # @return [String]
          def default_setting_value(parser)
            parser.parse!(path.join(INSTALLER_PLUGIN_DEFAULT_SETTINGS_PATH).read)
          end
        end
      end
    end
  end
end
