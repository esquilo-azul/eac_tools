# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class Deploy < ::Avm::EacRailsBase1::Instances::Deploy
        set_callback :assert_instance_branch, :after, :run_installer

        def run_installer
          infom 'Running installer'
          instance.run_installer
        end
      end
    end
  end
end
