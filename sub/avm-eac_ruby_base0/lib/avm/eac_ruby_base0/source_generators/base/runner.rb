# frozen_string_literal: true

require 'avm/eac_ruby_base1/source_generators/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRubyBase0
    module SourceGenerators
      class Base < ::Avm::EacRubyBase1::SourceGenerators::Base
        module Runner
          # @return [String]
          def runner_class
            runner_require_path.to_path.camelize
          end

          # @return [Pathname]
          def runner_require_path
            lib_path.to_pathname.join('runner')
          end

          # @return [Pathname]
          def runner_target_path
            target_path.join('lib', "#{runner_require_path}.rb")
          end

          protected

          # @return [void]
          def generate_runner
            template.child('runner').apply_to_file(self, runner_target_path.assert_parent)
          end
        end
      end
    end
  end
end
