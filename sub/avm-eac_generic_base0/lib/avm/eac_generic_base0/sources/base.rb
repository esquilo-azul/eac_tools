# frozen_string_literal: true

require 'avm/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGenericBase0
    module Sources
      class Base < ::Avm::Sources::Base
        require_sub __FILE__, include_modules: true
        enable_abstract_methods

        def valid?
          configuration_paths.any?(&:exist?)
        end
      end
    end
  end
end
