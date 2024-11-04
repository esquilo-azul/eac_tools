# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/macros/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      module Macros
        class ChildDocs < ::Avm::EacAsciidoctorBase0::Instances::Macros::Base
          DEFAULT_MAXIMUM_DEPTH = -1

          # @return [Array<String>]
          def result
            document_builder_class.new(self, document).result
          end

          # @return [Integer]
          def maximum_depth
            arguments[0].if_present(DEFAULT_MAXIMUM_DEPTH, &:to_i)
          end

          private

          # @return [Class]
          def document_builder_class
            ::Avm::EacAsciidoctorBase0::Instances::Macros::ChildDocs::DocumentBuilder
          end

          require_sub __FILE__
        end
      end
    end
  end
end
