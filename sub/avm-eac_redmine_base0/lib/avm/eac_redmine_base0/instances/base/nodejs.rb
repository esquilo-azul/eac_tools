# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedmineBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        module Nodejs
          DEFAULT_NODEJS_VERSION = '19.8.1'
          NODEJS_VERSION_KEY = 'nodejs.version'

          def auto_install_nodejs_version
            inherited_entry_value(::Avm::Instances::EntryKeys::INSTALL_ID, NODEJS_VERSION_KEY) ||
              DEFAULT_NODEJS_VERSION
          end
        end
      end
    end
  end
end
