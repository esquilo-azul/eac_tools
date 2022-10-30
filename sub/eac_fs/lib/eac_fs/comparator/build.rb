# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacFs
  class Comparator
    class Build
      TRUNCATE_FILE_CONTENT = "__TRUNCATED__\n"

      enable_method_class
      common_constructor :comparator, :root
      delegate :rename_files, :truncate_files, to: :comparator

      # @return [Hash]
      def result
        build(root)
      end

      private

      def build(obj)
        if obj.file?
          build_file(obj)
        elsif obj.directory?
          build_directory(obj)
        else
          raise "Unknown filesystem object \"#{obj}\""
        end
      end

      # @param dir [Pathname]
      # @return [Hash]
      def build_directory(dir)
        dir.children.map do |child|
          [fs_object_basename(child), build(child)]
        end.to_h
      end

      # @param file [Pathname]
      # @return [Hash]
      def build_file(file)
        truncate_file?(file) ? TRUNCATE_FILE_CONTENT : file.read
      end

      # @return [String]
      def fs_object_basename(obj)
        rename_files.inject(obj.basename.to_path) { |a, e| e.apply(a) }
      end

      def truncate_file?(file)
        truncate_files.include?(file.basename.to_path)
      end
    end
  end
end
