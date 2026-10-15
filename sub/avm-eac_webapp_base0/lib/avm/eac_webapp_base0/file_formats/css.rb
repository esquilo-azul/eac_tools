# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module FileFormats
      class Css < ::Avm::EacGenericBase0::FileFormats::Base
        VALID_BASENAMES = %w[*.css *.scss].freeze
        VALID_TYPES = [].freeze

        def file_apply(file)
          ::Avm::EacWebappBase0::FileFormats::Css::FileApply.new(file).perform
          super
        end
      end
    end
  end
end
