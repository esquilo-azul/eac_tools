# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacGenericBase0
    class FileFormats
      class Base < ::Avm::FileFormats::Base
        module FileResourceNameHelper
          def result_from_patterns(patterns, path, &block)
            patterns.lazy.map { |pattern| pattern.to_parser.parse(path.to_path) }
              .find(&:present?).if_present(&block)
          end

          def result_from_superclass(path)
            self.class.superclass.instance_method(:file_resource_name)
              .bind_call(self, path)
          end
        end
      end
    end
  end
end
