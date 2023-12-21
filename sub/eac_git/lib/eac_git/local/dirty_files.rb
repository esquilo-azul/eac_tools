# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ostruct'

module EacGit
  class Local
    module DirtyFiles
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

      def parse_status_line(line)
        STATUS_LINE_PATTERN.if_match(line) do |m|
          { index: m[1], worktree: m[2], path: m[3].to_pathname,
            absolute_path: m[3].to_pathname.expand_path(root_path) }.to_struct
        end
      end
    end
  end
end
