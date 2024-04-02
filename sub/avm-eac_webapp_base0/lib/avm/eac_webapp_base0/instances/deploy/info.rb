# frozen_string_literal: true

require 'avm/eac_webapp_base0/instances/deploy_info'
require 'avm/eac_webapp_base0/instances/base/deploy_info'

module Avm
  module EacWebappBase0
    module Instances
      class Deploy
        module Info
          # @return [Hash]
          def deploy_info
            ::Avm::EacWebappBase0::Instances::DeployInfo.from_hash(
              {
                instance_id: instance.id,
                time: ::Time.now,
                commit_id: commit_reference,
                commit_refs: version_git_refs,
                version: version_number
              }
            )
          end

          # @return [String]
          def version
            deploy_info.to_yaml
          end

          def version_git_refs
            git_remote_hashs.select { |_name, sha1| sha1 == commit_reference }.keys
              .map { |ref| ref.gsub(%r{\Arefs/}, '') }.reject { |ref| ref == 'HEAD' }
          end

          # @return [String, nil]
          def version_number
            instance.application.local_source.version.if_present(&:to_s)
          end

          # @return [String]
          def version_target_path
            ::Avm::EacWebappBase0::Instances::Base::DeployInfo::DEPLOY_INFO_SUBPATH
          end
        end
      end
    end
  end
end
