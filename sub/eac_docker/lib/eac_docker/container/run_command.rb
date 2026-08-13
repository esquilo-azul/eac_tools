# frozen_string_literal: true

module EacDocker
  class Container
    class RunCommand
      acts_as_instance_method
      common_constructor :container, :extra_args, default: [[]]
      delegate :capabilities, :command_args, :envs, :image, :interactive?, :temporary?, :tty?,
               :volumes, to: :container

      # @return [EacRubyUtils::Envs::Command]
      def result
        ::EacDocker::Executables.docker.command('run', *all_args)
      end

      # @return [Array<String>]
      def all_args
        %w[boolean capabilities envs volumes]
          .inject([]) { |a, e| a + send("#{e}_args") } +
          extra_args + [image.provide.id] + command_args
      end

      # @return [Array<String>]
      def boolean_args
        r = []
        r << '--interactive' if interactive?
        r << '--tty' if tty?
        r << '--rm' if temporary?
        r
      end

      # @return [Array<String>]
      def capabilities_args
        capabilities.flat_map { |capability| ['--cap-add', capability] }
      end

      # @return [Array<String>]
      def envs_args
        envs.flat_map { |name, value| ['--env', "#{name}=#{value}"] }
      end

      # @return [Array<String>]
      def volumes_args
        volumes.flat_map { |volume| ['--volume', volume] }
      end
    end
  end
end
