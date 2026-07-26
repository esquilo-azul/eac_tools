# frozen_string_literal: true

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
        end
      end
    end
  end
end
