# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Registry
    class ApplicationStereotypes
      require_sub __FILE__, require_dependency: true
      enable_simple_cache

      common_constructor :module_suffix

      def detect_optional(obj)
        detect_by_instance_class(obj) || detect_by_source_class(obj) || detecy_by_name(obj)
      end

      private

      def available_uncached
        build_available
      end

      # @return [Avm::Instances::Base, nil]
      def class_detect(klass, detect_args)
        r = ::Avm::Instances::Base.by_id(*detect_args)
        r.application.stereotype.instance_class == klass ? r : nil
      end

      def detect(*registered_initialize_args)
        detect_optional(*registered_initialize_args) ||
          raise_not_found(*registered_initialize_args)
      end

      def detect_by_instance_class(obj)
        return nil unless obj.is_a?(::Class) && obj < ::Avm::Instances::Base

        available.find { |a| a.instance_class == obj }
      end

      def detecy_by_name(obj)
        return nil unless obj.is_a?(::String)

        available.find { |a| a.name == obj }
      end

      def detect_by_source_class(obj)
        return nil unless obj.is_a?(::Class) && obj < ::Avm::Sources::Base

        available.find { |a| a.source_class == obj }
      end
    end
  end
end
