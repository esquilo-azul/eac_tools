# frozen_string_literal: true

module EacGit
  class Local
    class Commit
      class ChangedFile
        enable_memoized

        attr_reader :commit, :diff_tree

        # @param commit [EacGit::Local::Commit]
        # @param diff_tree_line [String] A line from command "repo diff-tree --no-commit-id -r
        #   --full-index"'s output.
        def initialize(commit, diff_tree_line)
          @commit = commit
          @diff_tree = ::EacGit::Local::Commit::DiffTreeLine.new(diff_tree_line)
        end

        delegate(*::EacGit::Local::Commit::DiffTreeLine::FIELDS, to: :diff_tree)

        def to_s
          "#{path}|#{status}"
        end

        memoize def src_size
          size(src_sha1)
        end

        memoize def dst_size
          size(dst_sha1)
        end

        private

        def size(id)
          return 0 if /\A0+\z/.match(id)

          commit.repo.command('cat-file', '-s', id).execute!.strip.to_i
        end
      end
    end
  end
end
