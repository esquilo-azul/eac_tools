# frozen_string_literal: true

require 'avm/executables'
require 'avm/eac_generic_base0/file_formats/base'

module Avm
  module EacPhpBase0
    module FileFormats
      class Base < ::Avm::EacGenericBase0::FileFormats::Base
        VALID_BASENAMES = %w[*.php].freeze
        VALID_TYPES = ['x-php'].freeze

        def file_apply(file)
          ::Avm::Executables.php_cs_fixer.command.append(['fix', file]).system!
          super(file)
        end
      end
    end
  end
end
