# frozen_string_literal: true

require 'avm/eac_generic_base0/file_formats/base'

module Avm
  module EacWebappBase0
    module FileFormats
      class Json < ::Avm::EacGenericBase0::FileFormats::Base
        VALID_BASENAMES = %w[*.json].freeze
        VALID_TYPES = [].freeze

        def file_apply(file)
          ::File.write(file, ::JSON.pretty_generate(::JSON.parse(::File.read(file))))
        end

        def json_file?(file)
          ::JSON.parse(::File.read(file))
          true
        rescue JSON::ParserError
          false
        end
      end
    end
  end
end
