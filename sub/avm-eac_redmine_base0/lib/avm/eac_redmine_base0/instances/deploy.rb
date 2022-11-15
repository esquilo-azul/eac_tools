# frozen_string_literal: true

require 'avm/eac_webapp_base0/instances/deploy'
require 'eac_ruby_utils/ruby'

module Avm
  module EacRedmineBase0
    module Instances
      class Deploy < ::Avm::EacWebappBase0::Instances::Deploy
        set_callback :assert_instance_branch, :after, :run_installer

        def run_installer
          infom 'Running installer'
          instance.run_installer
        end
      end
    end
  end
end
