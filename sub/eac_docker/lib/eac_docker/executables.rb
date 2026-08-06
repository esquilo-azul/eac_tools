# frozen_string_literal: true

module EacDocker
  module Executables
    class << self
      def env
        ::EacRubyUtils::Envs.local
      end

      def docker
        @docker ||= env.executable('docker', '--version')
      end
    end
  end
end
