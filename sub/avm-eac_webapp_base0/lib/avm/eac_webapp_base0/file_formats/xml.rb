# frozen_string_literal: true

require 'avm/eac_generic_base0/file_formats/base'
require 'avm/eac_webapp_base0/executables'

module Avm
  module EacWebappBase0
    module FileFormats
      class Xml < ::Avm::EacGenericBase0::FileFormats::Base
        VALID_BASENAMES = %w[*.xml].freeze
        VALID_TYPES = ['xml'].freeze

        def internal_apply(files)
          format_command(files).system!
          super(files)
        end

        def format_command(files)
          ::Avm::EacWebappBase0::Executables.tidy.command.append(
            %w[-xml -modify --indent auto --indent-spaces 2 --wrap 100] + files
          )
        end
      end
    end
  end
end
