# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      module Runners
        class Project
          class WikiPage
            class Write
              runner_with :help, :confirmation, :input do
                bool_opt '-f', '--force'
              end
              delegate :force?, to: :parsed

              def run
                start_banner
                if write?
                  run_write
                else
                  success 'Content unchanged, no further action will be taken'
                end
              end

              def start_banner
                infov 'Content'
                infov '  * Current', current_content
                infov '  * New', new_content
                infov '  * Changed?', content_changed?
              end

              # @return [Boolean]
              def content_changed?
                new_content != current_content
              end

              def run_write
                if confirm?('Write?')
                  infom 'Writing...'
                  runner_context.call(:wiki_page).write(new_content)
                  success('Writed!')
                else
                  success('Unconfirmed, no further action will be taken')
                end
              end

              # @return [Boolean]
              def write?
                parsed.force? || content_changed?
              end

              private

              # @return [String]
              def current_content_uncached
                runner_context.call(:wiki_page_content)
              end

              # @return [String]
              def new_content_uncached
                input_content
              end
            end
          end
        end
      end
    end
  end
end
