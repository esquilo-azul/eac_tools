# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_templates/interface_methods'

module EacTemplates
  module Modules
    class Ancestor
      class << self
        # @param a_module [Module]
        # @return [Pathname]
        def path_for_search(a_module)
          a_module.name.underscore.to_pathname
        end
      end

      common_constructor :base, :ancestor
      delegate :subpath, :source_set, to: :base
      delegate(*::EacTemplates::InterfaceMethods::ALL, to: :source_object)

      # @return [Pathname]
      def path_for_search
        r = self.class.path_for_search(ancestor)
        subpath.if_present(r) { |v| r.join(v) }
      end

      # @return [EacTemplates::Variables::SourceFile, EacTemplates::Variables::SourceNode]
      def source_object
        source_set.template(path_for_search)
      end
    end
  end
end