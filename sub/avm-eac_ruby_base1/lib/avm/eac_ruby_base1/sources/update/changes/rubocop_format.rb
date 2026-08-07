# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Sources
      module Update
        module Changes
          class RubocopFormat < ::Avm::Sources::Change
            # @return [void]
            def perform
              return if autofix

              disable_offenses
              autofix
            end

            # @return [Boolean]
            def autofix
              source.rubocop_root_command.autocorrect(true).system
            end

            # @return [void]
            def disable_offenses
              source.rubocop_offenses.disable_all
            end
          end
        end
      end
    end
  end
end
