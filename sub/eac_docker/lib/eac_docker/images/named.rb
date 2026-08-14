# frozen_string_literal: true

module EacDocker
  module Images
    class Named < ::EacDocker::Images::Base
      common_constructor :source_tag

      # @return [Boolean]
      def exist?
        ::EacDocker::Executables.docker.command('image', 'inspect', source_tag).execute
          .fetch(:exit_code).zero?
      end

      def id
        source_tag
      end

      def provide
        provide_command.execute! unless exist?
        self
      end

      def provide_command
        ::EacDocker::Executables.docker.command(*docker_provide_args)
      end

      def docker_provide_args
        ['pull', source_tag]
      end
    end
  end
end
