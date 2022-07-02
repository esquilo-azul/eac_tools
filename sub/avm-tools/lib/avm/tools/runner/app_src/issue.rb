# frozen_string_literal: true

require 'avm/tools/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Issue
          require_sub __FILE__
          runner_with :help, :subcommands do
            desc 'Issue operations within Git.'
            subcommands
          end
        end
      end
    end
  end
end
