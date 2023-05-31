# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/processes/daemon'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase1
    module Instances
      module Processes
        class TasksScheduler < ::Avm::EacRailsBase1::Instances::Processes::Daemon
          GEM_NAME = 'tasks_scheduler'
          COMMAND_NAME = 'tasks_scheduler'

          # @return [String]
          def command_name
            COMMAND_NAME
          end

          # @return [String]
          def gem_name
            GEM_NAME
          end
        end
      end
    end
  end
end
