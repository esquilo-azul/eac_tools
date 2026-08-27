# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      module Runners
        class Project
          class WikiPage
            runner_with :help, :subcommands do
              pos_arg :name
              subcommands
            end

            def wiki_page
              runner_context.call(:project).wiki_page(parsed.name)
            end

            def wiki_page_content
              wiki_page.read
            end
          end
        end
      end
    end
  end
end
