# frozen_string_literal: true

require 'ostruct'

module EacGit
  class Local
    module DirtyFiles
      QUOTED_PATH_PATTERN = /\A"(.+)"\z/.freeze
      STATUS_LINE_PATTERN = /\A(.)(.)\s(.+)\z/.freeze

      def dirty?
        dirty_files.any?
      end

      def dirty_file?(path)
        absolute_path = path.to_pathname.expand_path(root_path)
        dirty_files.any? do |df|
          df.absolute_path == absolute_path
        end
      end

      def dirty_files
        command('status', '--porcelain=v1', '--untracked-files', '--no-renames')
          .execute!.each_line.map { |line| parse_status_line(line.gsub(/\n\z/, '')) }
      end

      private

      # @param line [String]
      # @return [Struct]
      def parse_status_line(line)
        STATUS_LINE_PATTERN.if_match(line) do |m|
          path = parse_status_line_path(m[3]).to_pathname
          { index: m[1], worktree: m[2], path: path, absolute_path: path.expand_path(root_path) }
            .to_struct
        end
      end

      # @param path [String]
      # @return [String]
      def parse_status_line_path(path)
        m = QUOTED_PATH_PATTERN.match(path)
        m ? m[1] : path
      end
    end
  end
end
