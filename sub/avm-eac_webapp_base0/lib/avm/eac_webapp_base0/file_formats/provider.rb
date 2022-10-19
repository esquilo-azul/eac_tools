# frozen_string_literal: true

require 'avm/eac_webapp_base0/file_formats/html'
require 'avm/eac_webapp_base0/file_formats/javascript'
require 'avm/eac_webapp_base0/file_formats/json'
require 'avm/eac_webapp_base0/file_formats/xml'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacWebappBase0
    module FileFormats
      class Provider
        ALL_NAMES = %w[html javascript json xml].freeze

        def all
          @all ||= ALL_NAMES.map do |name|
            ::Avm::EacWebappBase0::FileFormats.const_get(name.camelize).freeze
          end
        end
      end
    end
  end
end
