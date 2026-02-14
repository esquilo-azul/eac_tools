# frozen_string_literal: true

module Avm
  module EacRailsBase1
    module Instances
      module Runners
        class CodeRunner
          runner_with :help, ::Avm::EacRailsBase1::RunnerWith::Bundle do
            desc 'Runs a Ruby code with "rails runner".'
            pos_arg :code
          end

          def run
            infov 'Environment', runner_context.call(:instance).host_env
            bundle_run
          end

          def bundle_args
            %w[exec rails runner] + [parsed.code]
          end
        end
      end
    end
  end
end
