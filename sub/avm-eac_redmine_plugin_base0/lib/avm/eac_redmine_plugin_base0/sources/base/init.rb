# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        module Init
          INIT_SUBPATH = 'init.rb'

          # @return [String]
          def init_path
            path.join(INIT_SUBPATH)
          end
        end
      end
    end
  end
end
