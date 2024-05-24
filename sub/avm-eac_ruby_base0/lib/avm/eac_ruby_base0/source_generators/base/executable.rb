# frozen_string_literal: true

require 'avm/eac_ruby_base1/source_generators/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRubyBase0
    module SourceGenerators
      class Base < ::Avm::EacRubyBase1::SourceGenerators::Base
        module Executable
          # @return [String]
          def executable_name
            options[OPTION_EXECUTABLE_NAME].if_present(name)
          end

          # @return [Pathname]
          def executable_target_path
            target_path.join(EXECUTABLES_DIRECTORY, executable_name)
          end

          protected

          # @return [void]
          def generate_executable
            template.child('executable').apply_to_file(self, executable_target_path.assert_parent)
          end
        end
      end
    end
  end
end
