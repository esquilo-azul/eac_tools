# frozen_string_literal: true

require 'avm/executables'
require 'avm/eac_generic_base0/file_formats/base'

module Avm
  module Files
    class Formatter
      module Formats
        class Python < ::Avm::EacGenericBase0::FileFormats::Base
          VALID_BASENAMES = %w[*.py].freeze
          VALID_TYPES = ['x-python'].freeze

          def internal_apply(files)
            ::Avm::Executables.yapf.command.append(['--in-place', *files]).system!
            super(files)
          end
        end
      end
    end
  end
end
