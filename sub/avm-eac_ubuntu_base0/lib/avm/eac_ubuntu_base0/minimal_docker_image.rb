# frozen_string_literal: true

module Avm
  module EacUbuntuBase0
    class MinimalDockerImage < ::Avm::Docker::Image
      BASE_IMAGE = 'ubuntu:24.04'
      STEREOTYPE_TAG = 'eac_ubuntu_base0_minimal'

      # @return [String]
      def base_image
        BASE_IMAGE
      end

      # @return [String]
      def stereotype_tag
        STEREOTYPE_TAG
      end
    end
  end
end
