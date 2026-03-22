# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      class Base < ::Avm::Instances::Base
        module DeployInfo
          common_concern

          DEPLOY_INFO_SUBPATH = '.deploy.yaml'

          # @return [Avm::EacWebappBase0::Instances::DeployInfo]
          def deploy_info
            ::Avm::EacWebappBase0::Instances::DeployInfo.from_string(
              host_env.command('cat', deploy_info_path).execute!
            )
          end

          # @return [Pathname]
          def deploy_info_path
            install_path.to_pathname.join(DEPLOY_INFO_SUBPATH)
          end
        end
      end
    end
  end
end
