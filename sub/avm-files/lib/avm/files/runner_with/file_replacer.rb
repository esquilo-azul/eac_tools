# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'avm/files/text_replacer'
require 'avm/files/runner_with/filesystem_traverser'

module Avm
  module Files
    module RunnerWith
      module FileReplacer
        common_concern do
          include ::Avm::Files::RunnerWith::FilesystemTraverser
          include TopMethods
        end

        module TopMethods
          def text_replacer
            ::Avm::Files::TextReplacer.new
          end

          def replace_file?(_file)
            true
          end

          def traverser_check_file(file)
            return unless replace_file?(file)

            infov 'Changed', file if text_replacer.file_apply(file)
          end
        end
      end
    end
  end
end
