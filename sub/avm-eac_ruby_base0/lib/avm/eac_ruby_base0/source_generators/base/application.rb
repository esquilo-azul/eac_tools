# frozen_string_literal: true

module Avm
  module EacRubyBase0
    module SourceGenerators
      class Base < ::Avm::EacRubyBase1::SourceGenerators::Base
        module Application
          # @return [Pathname]
          def application_to_root_relative_path
            target_path.relative_path_from(application_target_path.dirname)
          end

          # @return [Pathname]
          def application_require_path
            lib_path.to_pathname.join('self')
          end

          # @return [Pathname]
          def application_target_path
            target_path.join('lib', "#{application_require_path}.rb")
          end

          protected

          # @return [void]
          def generate_application
            template.child('application').apply_to_file(self, application_target_path.assert_parent)
          end
        end
      end
    end
  end
end
