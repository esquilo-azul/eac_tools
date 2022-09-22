# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedmineBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        module Database
          DATABASE_INTERNAL_HOSTNAME = 'localhost'

          def database_internal
            entry(::Avm::Instances::EntryKeys::DATABASE_HOSTNAME).value ==
              DATABASE_INTERNAL_HOSTNAME
          end
        end
      end
    end
  end
end
