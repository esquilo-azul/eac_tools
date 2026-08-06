# frozen_string_literal: true

module Avm
  module EacUbuntuBase0
    module Runners
      class Base < ::Avm::Runners::Base
        enable_simple_cache
        require_sub __FILE__

        INSTANCE_ID = 'eac-ubuntu-base0_self'

        runner_with :help, :subcommands do
          subcommands
        end

        for_context :instance

        private

        def instance_uncached
          ::Avm::EacUbuntuBase0::Instances::Base.by_id(INSTANCE_ID)
        end
      end
    end
  end
end
