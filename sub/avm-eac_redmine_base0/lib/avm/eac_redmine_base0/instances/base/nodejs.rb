# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        module Nodejs
          DEFAULT_NODEJS_VERSION = '19.8.1'
          NODEJS_VERSION_KEY = 'nodejs.version'

          # @return [String]
          def auto_install_nodejs_version
            application.local_source.default_nodejs_version.if_present(&:to_s) ||
              inherited_entry_value(::Avm::Instances::EntryKeys::INSTALL_ID, NODEJS_VERSION_KEY) ||
              DEFAULT_NODEJS_VERSION
          end
        end
      end
    end
  end
end
