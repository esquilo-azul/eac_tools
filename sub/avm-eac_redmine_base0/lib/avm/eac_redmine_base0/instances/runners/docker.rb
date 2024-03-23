# frozen_string_literal: true

require 'avm/docker/runner'

module Avm
  module EacRedmineBase0
    module Instances
      module Runners
        class Docker < ::Avm::Docker::Runner
          def use_default_registry?
            false
          end
        end
      end
    end
  end
end
