# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Sources
      class Base < ::Avm::EacRailsBase1::Sources::Base
        module Update
          # @param changes [Enumerable<Avm::Sources::Change>]
          def update_self_changes_after_subs
            super.grep_v(::Avm::EacRubyBase1::Sources::Update::Changes::RubocopFormat)
          end
        end
      end
    end
  end
end
