# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      module Processes
        class WebServer < ::Avm::Instances::Process
          def available?
            instance.apache_resource.present?
          end

          def enable
            apache_resource_change(__method__)
          end

          def enabled?
            instance.apache_resource.enabled?
          end

          def disable
            apache_resource_change(__method__)
          end

          private

          def apache_resource_change(action)
            instance.apache_resource.send(action)
            instance.platform_instance.apache.service(:reload)
          end
        end
      end
    end
  end
end
