# frozen_string_literal: true

module Avm
  module EacLatexBase0
    module Sources
      module Runners
        class Info
          runner_with :help do
            desc 'Information about a loca EacRailsBase0 local project.'
          end

          def run
            runner_context.call(:project_banner)
            infov 'Chapters', project.chapters.count
            project.chapters.each_with_index do |chapter, index|
              infov "  * #{index + 1}", chapter
            end
          end

          private

          def project
            runner_context.call(:project)
          end
        end
      end
    end
  end
end
