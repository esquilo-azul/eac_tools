# frozen_string_literal: true

module EacGit
  class Local
    class ChangedFile
      QUOTED_PATH_PATTERN = /\A"(.+)"\z/.freeze
      STATUS_LINE_PATTERN = /\A(.)(.)\s(.+)\z/.freeze

      class << self
        def by_porcelain_v1_line(local_repo, line)
          STATUS_LINE_PATTERN.match(line.gsub(/\n\z/, '')).then do |m|
            new(local_repo, m[1], m[2], parse_status_line_path(m[3]).to_pathname)
          end
        end

        # @param path [String]
        # @return [String]
        def parse_status_line_path(path)
          m = QUOTED_PATH_PATTERN.match(path)
          m ? m[1] : path
        end
      end

      common_constructor :local_repo, :index, :worktree, :path

      # @return [Pathname]
      def absolute_path
        path.expand_path(local_repo.root_path)
      end

      # @return [Boolean]
      def add?
        (index == '?' && worktree == '?') || (index == 'A' && worktree == ' ')
      end

      # @return [Boolean]
      def delete?
        [index, worktree].include?('D')
      end

      # @return [Boolean]
      def modify?
        [index, worktree].include?('M')
      end
    end
  end
end
