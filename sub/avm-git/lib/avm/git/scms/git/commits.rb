# frozen_string_literal: true

require 'avm/scms/commit'
require 'eac_ruby_utils/core_ext'

module Avm
  module Git
    module Scms
      class Git < ::Avm::Scms::Base
        module Commits
          # @return [Avm::Git::Scms::Git::Commit,nil]
          def commit(source)
            if source.is_a?(::Avm::Git::Scms::Git::Commit)
              return source if source.git_repo == git_repo

              raise 'Not same Git repository'
            end
            git_repo.commitize(source).if_present do |v|
              ::Avm::Git::Scms::Git::Commit.new(self, v)
            end
          end

          # @return [Avm::Git::Scms::Git::Commit,nil]
          def commit_dirty(message = nil)
            return nil unless git_repo.dirty?

            git_repo.command('add', '.').execute!
            git_repo.command(
              'commit', '-m',
              message.call_if_proc.if_present(COMMIT_DIRTY_DEFAULT_MESSAGE)
            ).execute!
            commit(git_repo.head)
          end

          # @return [Avm::Git::Scms::Git::Commit,nil]
          def commit_if_change(message = nil)
            tracker = ::Avm::Git::Scms::Git::ChangeTracker.new(self, message)
            tracker.start
            yield
            tracker.stop
          end

          # @return [Avm::Git::Scms::Git::Commit]
          def reset_and_commit(commit_to_reset, message)
            git_repo.command('reset', '--soft', commit(commit_to_reset).git_commit.id).execute!
            commit_dirty(message)
          end
        end
      end
    end
  end
end
