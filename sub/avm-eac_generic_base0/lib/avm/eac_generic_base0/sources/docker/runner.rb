# frozen_string_literal: true

require 'eac_cli/core_ext'

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
          end

          def run
            start_banner
            docker_container.run_command.system!
          end

          def start_banner
            infov 'Image', docker_image
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

          def default_command_args
            bash_command_args
          end

          def docker_container
            docker_image.container
              .volume(runner_context.call(:subject).path, CONTAINER_SOURCE_PATH)
              .interactive(true).tty(true).command_args(command_args)
          end

          # @return [EacDocker::Images::Base]
          def docker_image
            raise_abstract_method __method__
          end
        end
      end
    end
  end
end
