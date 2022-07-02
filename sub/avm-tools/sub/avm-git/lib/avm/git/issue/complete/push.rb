# frozen_string_literal: true

module Avm
  module Git
    module Issue
      class Complete
        module Push
          def dry_push_args
            %w[push --dry-run] + [remote_name] + pushs
          end

          def dry_push_result
            return ::Avm::Result.error('Nothing to push') if pushs.empty?

            dry_push_execution_result
          end

          def push
            if pushs.empty?
              info 'PUSH: Nada a enviar'
            else
              info "PUSH: enviando \"#{pushs}\"..."
              git_execute(%w[push origin] + pushs)
            end
          end

          def pushs_uncached
            [master_push, remove_branch_push, tag_push].reject(&:nil?)
          end

          def master_push
            remote_master_hash != branch_hash ? "#{branch_hash}:refs/heads/master" : nil
          end

          def remove_branch_push
            remote_branch_hash ? ":refs/heads/#{branch.name}" : nil
          end

          def tag_push
            return nil unless !remote_tag_hash || remote_tag_hash != branch_hash

            "#{branch_hash}:#{tag}"
          end

          private

          def dry_push_execution_result
            r = launcher_git.execute(dry_push_args)
            message = if r.fetch(:exit_code).zero?
                        'ok'
                      else
                        r.fetch(:stderr) + "\n#{::Shellwords.join(dry_push_args)}"
                      end
            ::Avm::Result.success_or_error(r.fetch(:exit_code).zero?, message)
          end
        end
      end
    end
  end
end
