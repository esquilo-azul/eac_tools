# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        module Database
          DATABASE_INTERNAL_HOSTNAME = ::Avm::Instances::Base::AutoValues::Database::LOCAL_ADDRESS
          DEFAULT_POSTGRESQL_VERSION = ''

          common_concern do
            uri_components_entries_values 'postgresql', %w[version]
          end

          def database_internal # rubocop:disable Naming/PredicateMethod
            ::Avm::Instances::Base::AutoValues::Database::LOCAL_ADDRESSES
              .include?(entry(::Avm::Instances::EntryKeys::DATABASE_HOSTNAME).value)
          end

          def postgresql_version_default_value
            DEFAULT_POSTGRESQL_VERSION
          end
        end
      end
    end
  end
end
