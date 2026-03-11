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

          # @return [ActiveSupport::Duration]
          def default_passenger_start_timeout
            default_setting_value('passenger_start_timeout').to_i.seconds
          end

          # @return [Avm::VersionNumber]
          def default_ruby_version
            ::Avm::VersionNumber.new(default_setting_value('ruby_version'))
          end

          # @param key [String]
          # @return [String]
          def default_setting_value(key)
            default_setting_parser(key)
              .parse!(path.join(INSTALLER_PLUGIN_DEFAULT_SETTINGS_PATH).read)
          end

          # @param key [String]
          # @return [EacRubyUtils::RegexpParser]
          def default_setting_parser(key)
            /#{::Regexp.quote(key)}='([^']+)'/.to_parser { |m| m[1] }
          end
        end
      end
    end
  end
end
