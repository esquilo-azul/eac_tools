# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Sources
      module Runners
        class Docker < ::Avm::EacGenericBase0::Sources::Docker::Runner
          # @return [Avm::EacUbuntuBase0::DockerImage]
          def docker_image
            ::Avm::EacUbuntuBase0::DockerImage.new
          end
        end
      end
    end
  end
end
