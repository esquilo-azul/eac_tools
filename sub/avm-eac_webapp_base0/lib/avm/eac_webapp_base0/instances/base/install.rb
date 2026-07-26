# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      class Base < ::Avm::Instances::Base
        module Install
          common_concern do
            uri_components_entries_values 'install', %w[apache_resource_name request_test_timeout]
          end

          def install_apache_resource_name_default_value
            id
          end

          # @return [Integer]
          def install_request_test_timeout_default_value
            ::EacEnvs::Http::Request::FaradayConnection::DEFAULT_TIMEOUT.in_seconds
          end
        end
      end
    end
  end
end
