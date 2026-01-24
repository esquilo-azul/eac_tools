# frozen_string_literal: true

module Avm
  module EacUbuntuBase0
    class DockerImage < ::Avm::Docker::Image
      BASE_IMAGE = 'ubuntu:24.04'
      USER_NAME = 'myuser'

      # @return [String]
      def base_image
        BASE_IMAGE
      end

      def stereotype_tag
        'eac_ubuntu_base0'
      end

      def user_home
        ::File.join('/home', user_name)
      end

      def user_name
        USER_NAME
      end

      def user_password
        user_name
      end
    end
  end
end
