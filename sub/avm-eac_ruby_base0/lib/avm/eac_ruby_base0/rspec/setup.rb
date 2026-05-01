# frozen_string_literal: true

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
