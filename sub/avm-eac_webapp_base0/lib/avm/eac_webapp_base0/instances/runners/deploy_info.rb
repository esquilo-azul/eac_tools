# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      module Runners
        class DeployInfo
          runner_with :help, :output_item do
            desc 'Fetch instance\'s last deploy information.'
          end

          def run
            run_output
          end

          # @return [Hash]
          def item_hash
            instance.deploy_info.to_h
          end
        end
      end
    end
  end
end
