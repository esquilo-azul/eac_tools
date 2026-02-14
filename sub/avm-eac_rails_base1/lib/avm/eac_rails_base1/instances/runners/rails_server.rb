# frozen_string_literal: true

require 'shellwords'

module Avm
  module EacRailsBase1
    module Instances
      module Runners
        class RailsServer
          DEFAULT_RAILS_ENVIRONMENT = 'development'
          runner_with :help, ::Avm::EacRailsBase1::RunnerWith::Bundle do
            desc 'Run the embbeded Rails web server.'
          end

          def run
            infov 'Environment', rails_environment
            infov 'Bundle args', ::Shellwords.join(bundle_args)
            infov 'Result', bundle_command.system
          end

          protected

          def bundle_args
            ['exec', 'rails', 'server', '--port',
             runner_context.call(:instance).read_entry(::Avm::Instances::EntryKeys::WEB_PORT)]
          end
        end
      end
    end
  end
end
