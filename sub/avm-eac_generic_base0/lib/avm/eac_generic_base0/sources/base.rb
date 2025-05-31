# frozen_string_literal: true

require 'avm/sources/base'

module Avm
  module EacGenericBase0
    module Sources
      class Base < ::Avm::Sources::Base
        require_sub __FILE__, include_modules: true
        enable_abstract_methods

        VERSION_FILE_SUBPATH = 'VERSION'

        def valid?
          configuration_paths.any?(&:exist?)
        end

        # @return [Avm::VersionNumber, nil]
        def version
          return nil unless version_file.file?

          ::Avm::VersionNumber.new(version_file.read)
        end

        # @param target_version [Avm::VersionNumber]
        def version=(target_version)
          version_file.write("#{target_version}\n")
        end

        # @param target_version [Avm::VersionNumber]
        def version_bump_do_changes(target_version)
          self.version = target_version
        end

        # @return [Pathname]
        def version_file
          path.join(VERSION_FILE_SUBPATH)
        end
      end
    end
  end
end
