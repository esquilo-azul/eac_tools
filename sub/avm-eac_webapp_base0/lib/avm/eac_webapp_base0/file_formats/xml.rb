# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module FileFormats
      class Xml < ::Avm::EacGenericBase0::FileFormats::Base
        VALID_BASENAMES = %w[*.svg *.xml].freeze
        VALID_TYPES = ['image/svg+xml', 'xml'].freeze

        def internal_apply(files)
          format_command(files).system!
          super
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
