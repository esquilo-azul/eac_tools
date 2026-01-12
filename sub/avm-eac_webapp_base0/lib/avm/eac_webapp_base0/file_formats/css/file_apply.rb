# frozen_string_literal: true

require 'avm/eac_generic_base0/file_formats/base'
require 'avm/eac_webapp_base0/executables'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacWebappBase0
    module FileFormats
      class Css < ::Avm::EacGenericBase0::FileFormats::Base
        class FileApply
          EXECUTABLE_NAME = 'cssbeautify-cli'
          EXECUTABLE_CHECK_ARGS = ['--version'].freeze
          EXECUTABLE_STATIC_ARGS = ['--autosemicolon', '--indent', '  ', '--openbrace',
                                    'end-of-line', '--stdin'].freeze

          common_constructor :file

          def perform
            on_temp_output_file do |_temp_file|
              run_command
            end
          end

          private

          attr_accessor :output_file

          def command
            ::Avm::EacWebappBase0::Executables.cssbeautify_cli.command(*EXECUTABLE_STATIC_ARGS)
          end

          def on_temp_output_file
            ::EacRubyUtils::Fs::Temp.on_file do |temp_output_file|
              self.output_file = temp_output_file
              yield
              ::FileUtils.mv(temp_output_file.to_path, file)
            end
          end

          def run_command
            command.system!(input_file: file, output_file: output_file.to_path)
          end
        end
      end
    end
  end
end
