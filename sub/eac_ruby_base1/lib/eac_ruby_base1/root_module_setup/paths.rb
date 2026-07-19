# frozen_string_literal: true

module EacRubyBase1
  class RootModuleSetup
    module Paths
      attr_reader :root_module_file

      # @return [String]
      def relative_root_module_file
        count = 0
        current = ::File.basename(root_module_file, '.*')
        dirname = ::File.dirname(root_module_file)
        loop do
          ibr if dirname == '/'

          break current if ::File.basename(dirname) == LIB_DIRECTORY_BASENAME

          current = ::File.join(::File.basename(dirname), current)
          dirname = ::File.dirname(dirname)

          count += 1
        end
      end

      # @return [String]
      def root_module_directory
        ::File.expand_path(::File.basename(root_module_file, '.*'),
                           ::File.dirname(root_module_file))
      end

      protected

      attr_writer :root_module_file
    end
  end
end
