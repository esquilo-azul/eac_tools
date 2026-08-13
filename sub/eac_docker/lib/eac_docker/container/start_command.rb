# frozen_string_literal: true

module EacDocker
  class Container
    # Start an already existing container identified by {#id}, if present, or {#name}.
    class StartCommand
      acts_as_instance_method
      common_constructor :container
      delegate :identifier, :interactive?, :tty?, to: :container

      # @return [EacRubyUtils::Envs::Command]
      def result
        ::EacDocker::Executables.docker.command('start', *start_args)
      end

      # @return [Array<String>]
      def start_args
        r = []
        r << '--attach' if interactive? || tty?
        r << '--interactive' if interactive?
        r << identifier
        r
      end
    end
  end
end
