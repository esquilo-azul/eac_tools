# frozen_string_literal: true

require 'avm/eac_latex_base0/sources/build'
require 'eac_cli/core_ext'

module Avm
  module EacLatexBase0
    module Sources
      module Runners
        class BuildSingle
          runner_with :help do
            arg_opt '-s', '--source-dir', 'Write .tex source code in specific directory.'
            arg_opt '-f', '--output-file', 'Output to specific file.'
            arg_opt '-c', '--chapter', 'Write only the chapter <chapter>.'
            bool_opt '-o', '--open', 'Open the file after build.'
          end

          def run
            runner_context.call(:project_banner)
            infov 'Build options', build_options
            ::Avm::EacLatexBase0::Sources::Build.new(runner_context.call(:project), parsed)
          end

          private

          def build_options
            parsed.slice_fetch(:output_file, :open, :chapter, :source_dir)
          end
        end
      end
    end
  end
end
