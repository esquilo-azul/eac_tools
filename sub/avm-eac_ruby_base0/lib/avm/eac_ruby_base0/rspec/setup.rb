# frozen_string_literal: true

require 'avm/eac_ruby_base0/rspec/source_generator'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRubyBase0
    module Rspec
      module Setup
        def self.extended(obj)
          obj.rspec_config.include(::Avm::EacRubyBase0::Rspec::SourceGenerator)
        end
      end
    end
  end
end
