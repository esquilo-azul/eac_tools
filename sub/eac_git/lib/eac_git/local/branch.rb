# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacGit
  class Local
    class Branch
      REFS_PREFIX = 'refs/heads/'

      common_constructor :local, :name

      # @return [String]
      # @deprecated Use {#head_commit_id} instead.
      def current_commit_id
        head_commit_id
      end

      # @return [Boolean]
      def exist?
        local.command('show-ref', '--quiet', full_ref_name).execute.fetch(:exit_code).zero?
      end

      def full_ref_name
        "#{REFS_PREFIX}#{name}"
      end

      # @return [EacGit::Local::Commit]
      def head_commit
        local.commit(head_commit_id, true)
      end

      # @return [String]
      def head_commit_id
        local.rev_parse(full_ref_name, true)
      end

      # @param remote [EacGit::Local::Remote]
      # @return [void]
      def push(remote, options = {})
        options[:refspec] = name
        options.inject(remote.push) do |a, e|
          a.send(*e)
        end.perform
      end
    end
  end
end
