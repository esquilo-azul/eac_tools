# frozen_string_literal: true

module Avm
  module EacGenericBase0
    module Sources
      module Docker
        class Runner
          CONTAINER_SOURCE_PATH = '/app'

          enable_abstract_methods
          abstract_methods :docker_image

          runner_with :help do
            desc 'Run a Docker container with source mapped.'
            arg_opt '-c', '--command-arg', 'Arguments for [COMMAND] [ARG...].', optional: true,
                                                                                repeat: true
            bool_opt '-n', '--new', 'Force the creation of a new container.'
          end

          # @return [void]
          def run
            start_banner
            new_container? ? run_container : start_container
          end

          # @return [void]
          def start_banner
            infov 'Image', docker_image
            infov 'Container name', container_name
            infov 'Container exist?', container_exist?
            infov 'New container?', new_container?
            infov 'Command', ::Shellwords.join(command_args)
          end

          def bash_command_args
            %w[/bin/bash]
          end

          def command_args
            if parsed.command_arg.any?
              parsed.command_arg
            else
              default_command_args
            end
          end

          # @return [Boolean]
          memoize def container_exist?
            docker_container.exist?
          end

          # Name that identifies the container associated with the source, so it can be
          # found and reused on the next run.
          #
          # @return [String]
          def container_name
            [
              self.class.name.parameterize,
              runner_context.call(:subject).path.to_s.parameterize
            ].join('_')
          end

          def default_command_args
            bash_command_args
          end

          def docker_container
            docker_image.container
              .volume(runner_context.call(:subject).path, CONTAINER_SOURCE_PATH)
              .interactive(true).tty(true).command_args(command_args).name(container_name)
          end

          # @return [EacDocker::Images::Base]
          def docker_image
            raise_abstract_method __method__
          end

          # @return [Boolean]
          def new_container?
            parsed.new? || !container_exist?
          end

          # Create and run a new container.
          #
          # @return [void]
          def run_container
            if container_exist?
              infom "Remove existing container \"#{container_name}\"..."
              docker_container.remove_command.execute!
            end

            infom "Creating container \"#{container_name}\"..."
            docker_container.run_command.system!
          end

          # Start the existing container associated with the source.
          #
          # @return [void]
          def start_container
            infom "Starting existing container \"#{container_name}\"..."
            docker_container.start_command.system!
          end
        end
      end
    end
  end
end
