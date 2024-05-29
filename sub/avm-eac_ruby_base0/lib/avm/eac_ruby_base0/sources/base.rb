# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRubyBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        # @return [Boolean]
        def valid?
          super && executable_path.file?
        end

        require_sub __FILE__, include_modules: true
      end
    end
  end
end
