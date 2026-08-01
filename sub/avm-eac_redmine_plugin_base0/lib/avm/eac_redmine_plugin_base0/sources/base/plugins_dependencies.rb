# frozen_string_literal: true

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        module PluginsDependencies
          DEPENDENCIES_SUBPATHS = %w[yml yaml].map { |e| "dependencies.#{e}" }

          # The possible absolute paths for the dependencies file.
          #
          # @return [Enumerable<Pathname>]
          def dependencies_file_paths
            DEPENDENCIES_SUBPATHS.map { |basename| path.join(basename) }
          end

          # @return [Pathname, nil]
          def dependencies_file
            dependencies_file_paths.find(&:file?)
          end
        end
      end
    end
  end
end
