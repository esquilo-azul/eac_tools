# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_templates/abstract/directory'
require 'eac_templates/interface_methods'
require 'eac_templates/modules/base/fs_object'

module EacTemplates
  module Modules
    class Base
      class Directory < ::EacTemplates::Abstract::Directory
        include ::EacTemplates::Modules::Base::FsObject
        delegate(*(EacTemplates::InterfaceMethods::DIRECTORY - %i[child children]),
                 to: :self_ancestor)

        # @!method build_child(child_basename, child_type)
        #   @param child_basename [Pathname]
        #   @param child_type [Symbol]
        #   @return [EacTemplates::Modules::Base]
        delegate :build_child, to: :owner

        # @return [Hash<Pathname, Symbol>]
        def children_basenames
          owner.ancestors.each_with_object({}) do |e, a|
            ancestor_children_names(e, a)
          end
        end

        # @return [Boolean]
        def found?
          children.any?
        end

        protected

        # @param ancestor []
        # @param result [Hash<Pathname, Symbol>]
        # @return [void]
        def ancestor_children_names(ancestor, result)
          ancestor.children_basenames.each do |path, type|
            result[path] = type
          end
        end
      end
    end
  end
end
