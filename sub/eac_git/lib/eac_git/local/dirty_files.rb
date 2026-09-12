# frozen_string_literal: true

require 'ostruct'

module EacGit
  class Local
    module DirtyFiles
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
          .execute!.each_line
          .map { |line| ::EacGit::Local::ChangedFile.by_porcelain_v1_line(self, line) }
      end
    end
  end
end
