# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/module_ancestors_variable/set'

module EacCli
  module Runner
    module ForContext
      common_concern

      module ClassMethods
        # @param methods_names [Enumerable<Symbol>]
        # @return [void]
        def for_context(*methods_names)
          for_context_methods.merge(methods_names.map(&:to_sym))
        end

        # @param method_name [Symbol]
        # @return [Boolean]
        def for_context?(method_name)
          for_context_methods.include?(method_name.to_sym)
        end

        private

        # @return [EacRubyUtils::ModuleAncestorsVariable::Set<Symbol>]
        def for_context_methods
          @for_context_methods ||=
            ::EacRubyUtils::ModuleAncestorsVariable::Set.new(self, __method__)
        end
      end

      # @param method_name [Symbol]
      # @return [Boolean]
      def for_context?(method_name)
        self.class.for_context?(method_name)
      end
    end
  end
end
