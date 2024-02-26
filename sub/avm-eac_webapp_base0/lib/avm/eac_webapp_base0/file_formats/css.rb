# frozen_string_literal: true

require 'avm/eac_generic_base0/file_formats/base'
require 'eac_ruby_utils/envs'

module Avm
  module EacWebappBase0
    module FileFormats
      class Css < ::Avm::EacGenericBase0::FileFormats::Base
        require_sub __FILE__

        VALID_BASENAMES = %w[*.css *.scss].freeze
        VALID_TYPES = [].freeze

        def file_apply(file)
          ::Avm::EacWebappBase0::FileFormats::Css::FileApply.new(file).perform
          super(file)
        end
      end
    end
  end
end
