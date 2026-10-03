# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Sources
      class CoreUpdate
        module Scm
          enable_memoized

          # @return [void]
          def git_commit
            if git_repo.dirty?
              infom 'Git commiting...'
              git_repo.command('add', '--', target_path).execute!
              git_repo.command('commit', '-m', git_commit_message, '--', target_path).execute!
            else
              infom 'Nothing to commit'
            end
          end

          # @return [String]
          def git_commit_message
            i18n_translate(__method__, version: version, __locale: source.locale)
          end

          # @return [EacGit::Local]
          memoize def git_repo
            ::EacGit::Local.new(target_path)
          end
        end
      end
    end
  end
end
