# frozen_string_literal: true

require 'avm/eac_webapp_base0/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacPhpBase0
    module Sources
      class Base < ::Avm::EacWebappBase0::Sources::Base
        # @return [Boolean]
        def valid?
          path.glob('*.php').any?(&:file?)
        end
      end
    end
  end
end
