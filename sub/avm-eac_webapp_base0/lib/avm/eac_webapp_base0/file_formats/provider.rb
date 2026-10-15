# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module FileFormats
      class Provider
        ALL_NAMES = %w[css html javascript json xml].freeze

        def all
          @all ||= ALL_NAMES.map do |name|
            ::Avm::EacWebappBase0::FileFormats.const_get(name.camelize)
          end.freeze
        end
      end
    end
  end
end
