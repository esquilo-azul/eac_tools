# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      module Runners
        class Project
          class WikiPage
            class Read
              runner_with :help, :output

              def run
                run_output
              end

              def output_content
                runner_context.call(:wiki_page_content)
              end
            end
          end
        end
      end
    end
  end
end
