# frozen_string_literal: true

require 'eac_cli/core_ext'

module Avm
  module EacWebappBase0
    module Instances
      module Runners
        class Data
          class Unit
            class Dump
              runner_with :help do
                pos_arg :dump_path
              end

              def run
                nyi
              end
            end
          end
        end
      end
    end
  end
end
