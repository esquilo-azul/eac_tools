# frozen_string_literal: true

require 'eac_cli/core_ext'

module Avm
  module EacWebappBase0
    module Instances
      module Runners
        class Data
          class Unit
            class Clear
              runner_with :help

              def run
                runner_context.call(:data_unit).clear
              end
            end
          end
        end
      end
    end
  end
end
