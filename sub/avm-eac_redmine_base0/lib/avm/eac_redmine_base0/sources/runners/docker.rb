# frozen_string_literal: true

require 'avm/docker/runner'

module Avm
  module EacRedmineBase0
    module Sources
      module Runners
        class Docker < ::Avm::Docker::Runner
          def docker_image
            ::Avm::EacUbuntuBase0::DockerImage
          end
        end
      end
    end
  end
end
