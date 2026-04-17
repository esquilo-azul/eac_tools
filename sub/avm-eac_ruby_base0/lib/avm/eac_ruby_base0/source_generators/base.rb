# frozen_string_literal: true

require 'avm/eac_ruby_base1/source_generators/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRubyBase0
    module SourceGenerators
      class Base < ::Avm::EacRubyBase1::SourceGenerators::Base
        require_sub __FILE__, include_modules: true

        COMMON_DEPENDENCIES = %w[eac_ruby_base0].freeze
        EXECUTABLES_DIRECTORY = 'exe'
        GEMSPEC_EXTRA_LINES = [
          "s.bindir = '#{EXECUTABLES_DIRECTORY}'",
          "s.executables = s.files.grep(%r{^#{EXECUTABLES_DIRECTORY}/}) { |f| File.basename(f) }"
        ].freeze
        GEMSPEC_FILES_DIRECTORY_PATHS = [EXECUTABLES_DIRECTORY].freeze
        GEMSPEC_FILES_FILE_PATHS = %w[Gemfile Gemfile.lock].freeze
        JOBS = ::Avm::EacRubyBase1::SourceGenerators::Base::JOBS + %w[application executable runner]
        OPTION_EXECUTABLE_NAME = 'executable-name'

        class << self
          # @return [Array<String>]
          def common_dependency_gems
            super + COMMON_DEPENDENCIES
          end
        end

        # @return [Array<String>]
        def gemspec_extra_lines
          super + GEMSPEC_EXTRA_LINES
        end

        # @return [Array<String>]
        def gemspec_files_directory_paths
          super + GEMSPEC_FILES_DIRECTORY_PATHS
        end

        # @return [Array<String>]
        def gemspec_files_file_paths
          super + GEMSPEC_FILES_FILE_PATHS
        end
      end
    end
  end
end
