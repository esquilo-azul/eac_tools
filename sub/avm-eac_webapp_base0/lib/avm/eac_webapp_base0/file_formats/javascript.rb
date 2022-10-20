# frozen_string_literal: true

require 'avm/eac_generic_base0/file_formats/base'
require 'avm/eac_webapp_base0/executables'

module Avm
  module EacWebappBase0
    module FileFormats
      class Javascript < ::Avm::EacGenericBase0::FileFormats::Base
        VALID_BASENAMES = %w[*.js].freeze
        VALID_TYPES = [].freeze

        def internal_apply(files)
          ::Avm::EacWebappBase0::Executables.js_beautify.command.append(
            ['--indent-size=2', '--end-with-newline', '--replace', *files]
          ).system!
          super(files)
        end
      end
    end
  end
end
