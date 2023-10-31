# frozen_string_literal: true

require 'eac_envs/http/request'
require 'avm/eac_webapp_base0/instances/deploy'

module Avm
  module EacRailsBase1
    module Instances
      class Deploy < ::Avm::EacWebappBase0::Instances::Deploy
        set_callback :write_on_target, :before do
          check_rubygems_access
        end

        # @return [void]
        # @raise [EacEnvs::Http::Error]
        def check_rubygems_access
          infom "Checkin access to gems provider (\"#{instance.gemfile_source}\")..."
          ::EacEnvs::Http::Request.new.url(instance.gemfile_source).response.body_data_or_raise
        end
      end
    end
  end
end
