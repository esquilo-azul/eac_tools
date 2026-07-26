# frozen_string_literal: true

module Avm
  module EacRailsBase1
    module Instances
      class Base < ::Avm::EacWebappBase0::Instances::Base
        module Install
          DEFAULT_INSTALL_PASSENGER_START_TIMEOUT = 300

          common_concern do
            uri_components_entries_values 'install', %w[passenger_start_timeout]
          end

          def install_passenger_start_timeout_default_value
            DEFAULT_INSTALL_PASSENGER_START_TIMEOUT
          end

          def install_request_test_timeout_default_value
            install_passenger_start_timeout
          end
        end
      end
    end
  end
end
