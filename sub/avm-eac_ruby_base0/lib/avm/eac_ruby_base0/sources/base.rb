# frozen_string_literal: true

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
