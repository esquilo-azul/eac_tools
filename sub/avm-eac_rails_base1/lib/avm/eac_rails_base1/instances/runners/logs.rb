# frozen_string_literal: true

require 'eac_cli/core_ext'

module Avm
  module EacRailsBase1
    module Instances
      module Runners
        class Logs
          require_sub __FILE__
          runner_with :help, :subcommands do
            desc 'Manipule multiple application\'s logs.'
            subcommands
          end
        end
      end
    end
  end
end
