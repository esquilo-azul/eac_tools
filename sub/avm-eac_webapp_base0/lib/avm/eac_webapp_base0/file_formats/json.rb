# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module FileFormats
      class Json < ::Avm::EacGenericBase0::FileFormats::Base
        VALID_BASENAMES = %w[*.json].freeze
        VALID_TYPES = [].freeze

        def json_file?(file)
          ::JSON.parse(::File.read(file))
          true
        rescue JSON::ParserError
          false
        end

        # @param string [String]
        # @return [String]
        def string_apply(string)
          super(::JSON.pretty_generate(::JSON.parse(string)))
        end
      end
    end
  end
end
