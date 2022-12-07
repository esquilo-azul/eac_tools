# frozen_string_literal: true

require 'avm/eac_python_base0/executables'
require 'avm/eac_generic_base0/file_formats/base'

module Avm
  module EacPythonBase0
    module FileFormats
      class Base < ::Avm::EacGenericBase0::FileFormats::Base
        VALID_BASENAMES = %w[*.py].freeze
        VALID_TYPES = ['x-python', 'x-script.python'].freeze

        def internal_apply(files)
          ::Avm::EacPythonBase0::Executables.yapf.command.append(['--in-place', *files]).system!
          super(files)
        end
      end
    end
  end
end
