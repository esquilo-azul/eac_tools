# frozen_string_literal: true

require 'avm/docker/runner'

module Avm
  module Tools
    class Runner
      class EacRedmineBase0 < ::Avm::EacRailsBase1::Runner
        class Docker < ::Avm::Docker::Runner
          def use_default_registry?
            false
          end
        end
      end
    end
  end
end
