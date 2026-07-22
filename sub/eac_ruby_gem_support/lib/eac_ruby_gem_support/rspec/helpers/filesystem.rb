# frozen_string_literal: true

require 'fileutils'
require 'tmpdir'
require 'tempfile'

module EacRubyGemSupport
  module Rspec
    module Helpers
      module Filesystem
        def purge_temp_files
          ::FileUtils.rm_rf(temp_set.pop) while temp_set.any?
        end

        # @return [Pathname]
        def temp_copy(source_path)
          source_path = to_pathname(source_path)
          if source_path.file?
            temp_file_copy(source_path)
          elsif source_path.directory?
            temp_dir_copy(source_path)
          else
            raise "Source path \"#{source_path}\" is not a file or directory"
          end
        end

        # @return [Pathname]
        def temp_dir(*mktmpdir_args)
          add_to_temp_set(::Dir.mktmpdir(*mktmpdir_args))
        end

        # @return [Pathname]
        def temp_dir_copy(source_path)
          r = temp_dir
          ::FileUtils.cp_r("#{source_path}/.", r.to_path)
          r
        end

        # @return [Pathname]
        def temp_file(*tempfile_args)
          file = ::Tempfile.new(*tempfile_args)
          path = file.path
          file.close
          add_to_temp_set(path)
        end

        # @return [Pathname]
        def temp_file_copy(source_path)
          r = temp_file
          ::FileUtils.cp(to_pathname(source_path).to_path, r.to_path)
          r
        end

        # @return [Pathname]
        def to_pathname(path)
          path.is_a?(::Pathname) ? path : ::Pathname.new(path.to_s)
        end

        private

        def add_to_temp_set(path)
          r = to_pathname(path)
          temp_set << r
          r
        end

        def temp_set
          @temp_set ||= []
        end
      end
    end
  end
end
