# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      class Deploy
        module Scm
          DEFAULT_REMOTE_NAME = 'origin'
          DEFAULT_REMOTE_READ = true

          def commit_reference_uncached
            git_fetch
            r = git.rev_parse(git_reference_found)
            return r if r

            raise ::Avm::Result::Error, "No commit SHA1 found for \"#{git_reference_found}\""
          end

          def git_fetch_uncached
            return unless remote_read?

            infom "Fetching remote \"#{git_remote_name}\" from \"#{git_repository_path}\"..."
            git.remote(git_remote_name).fetch
          end

          def git_reference
            options[OPTION_REFERENCE] || DEFAULT_REFERENCE
          end

          def git_reference_found_uncached
            %w[git_reference instance_branch master_branch].map { |b| send(b) }.find(&:present?) ||
              raise(
                ::Avm::Result::Error,
                'No git reference found (Searched for option, instance and master)'
              )
          end

          def git_remote_hashs_uncached
            return {} unless remote_read?

            git.remote(git_remote_name).ls.hashes
          end

          def git_remote_name
            DEFAULT_REMOTE_NAME
          end

          def git_repository_path
            instance.source_instance.read_entry(::Avm::Instances::EntryKeys::INSTALL_PATH)
          end

          # @return [EacGit::Local]
          def git_uncached
            scm.git_repo
          end

          def instance_branch
            remote_branch(instance.id)
          end

          def remote_branch(name)
            git_remote_hashs.key?("refs/heads/#{name}") ? "#{git_remote_name}/#{name}" : nil
          end

          def master_branch
            remote_branch('master')
          end

          # @return [Boolean]
          def remote_read?
            options.if_key(OPTION_REMOTE_READ, DEFAULT_REMOTE_READ).to_bool
          end

          # @return [Avm::Scms::Base]
          def scm
            instance.application.local_source.scm
          end
        end
      end
    end
  end
end
