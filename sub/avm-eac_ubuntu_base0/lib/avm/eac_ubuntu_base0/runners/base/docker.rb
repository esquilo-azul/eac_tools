# frozen_string_literal: true

module Avm
  module EacUbuntuBase0
    module Runners
      class Base < ::Avm::Runners::Base
        class Docker < ::Avm::Docker::Runner
          def use_default_registry?
            true
          end
        end
      end
    end
  end
end
