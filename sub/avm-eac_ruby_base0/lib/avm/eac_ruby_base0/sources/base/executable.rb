# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRubyBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        module Executable
          EXECUTABLE_NAME_KEY = 'executable.name'
          EXECUTABLE_DIRECTORY_KEY = 'executable.directory'
          DEFAULT_EXECUTABLE_DIRECTORY = 'exe'

          # @return [String]
          def default_executable_name
            application.id
          end

          # @return [String]
          def default_executable_directory
            DEFAULT_EXECUTABLE_DIRECTORY
          end

          # @return [String]
          def executable_directory
            executable_directory_by_configuration || default_executable_directory
          end

          # @return [String, nil]
          def executable_directory_by_configuration
            configuration.entry(EXECUTABLE_DIRECTORY_KEY).value
          end

          # @return [String]
          def executable_name
            executable_name_by_configuration || default_executable_name
          end

          # @return [String, nil]
          def executable_name_by_configuration
            configuration.entry(EXECUTABLE_NAME_KEY).value
          end

          # Executable's absolute path.
          #
          # @return [Pathname]
          def executable_path
            path.join(executable_subpath)
          end

          # Executable's relative path from source's root.
          #
          # @return [Pathname]
          def executable_subpath
            executable_directory.to_pathname.join(executable_name)
          end
        end
      end
    end
  end
end
