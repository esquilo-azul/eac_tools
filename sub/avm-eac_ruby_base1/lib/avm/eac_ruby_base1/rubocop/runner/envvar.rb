# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Rubocop
      class Runner
        module Envvar
          RUBOCOP_COMMAND_ENVVAR_NAME = 'RUBOCOP_COMMAND'

          def env_rubocop_command
            ENV[RUBOCOP_COMMAND_ENVVAR_NAME].present? ? cmd(ENV[RUBOCOP_COMMAND_ENVVAR_NAME]) : nil
          end
        end
      end
    end
  end
end
