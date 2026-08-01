# frozen_string_literal: true

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        module Update
          # @param changes [Enumerable<Avm::Sources::Change>]
          def update_self_changes_after_subs
            super + [
              ::Avm::EacRedminePluginBase0::Sources::UpdateChanges::PluginsRequirements.new(self)
            ]
          end
        end
      end
    end
  end
end
