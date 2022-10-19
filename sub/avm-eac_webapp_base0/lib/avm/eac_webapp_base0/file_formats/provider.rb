# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacWebappBase0
    module FileFormats
      class Provider
        ALL_NAMES = %w[].freeze

        def all
          @all ||= ALL_NAMES.map do |name|
            ::Avm::EacWebappBase0::FileFormats.const_get(name.camelize).freeze
          end
        end
      end
    end
  end
end
