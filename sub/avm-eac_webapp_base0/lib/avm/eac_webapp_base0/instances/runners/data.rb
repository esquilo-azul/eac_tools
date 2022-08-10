# frozen_string_literal: true

require 'eac_cli/core_ext'

module Avm
  module EacWebappBase0
    module Instances
      module Runners
        class Data
          require_sub __FILE__
          runner_with :help, :subcommands do
            desc 'Data utilities for EacRailsBase0 instances.'
            subcommands
          end
        end
      end
    end
  end
end
