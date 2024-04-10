# frozen_string_literal: true

require 'eac_cli/core_ext'

module Avm
  module EacRedmineBase0
    module Instances
      module Runners
        class Project
          runner_with :help, :subcommands do
            pos_arg :id_or_identifier
            subcommands
          end

          private

          def project_uncached
            runner_context.call(:instance).rest_api.root_entity.project(parsed.id_or_identifier)
          end

          require_sub __FILE__
        end
      end
    end
  end
end
