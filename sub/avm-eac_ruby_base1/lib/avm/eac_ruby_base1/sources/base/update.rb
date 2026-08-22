# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Sources
      class Base < ::Avm::EacGenericBase0::Sources::Base
        module Update
          # @return [void]
          def on_sub_updated
            ::Avm::EacRubyBase1::Sources::Update::Changes::GemfileLock.new(self).perform
          end

          # @param changes [Enumerable<Avm::Sources::Change>]
          def update_self_changes_after_subs
            super + [
              ::Avm::EacRubyBase1::Sources::Update::Changes::DependenciesRequirements.new(self),
              ::Avm::EacRubyBase1::Sources::Update::Changes::RubocopFormat.new(self)
            ]
          end

          # @param changes [Enumerable<Avm::Sources::Change>]
          def update_self_changes_before_subs
            super + [
              ::Avm::EacRubyBase1::Sources::Update::Changes::GemfileLock.new(self)
            ]
          end
        end
      end
    end
  end
end
