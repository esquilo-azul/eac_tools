# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Sources
      class CoreUpdate
        module SourcePackage
          enable_memoized

          # @return [void]
          def assert_source_package
            infom 'Asserting source package...'
            source_package.assert
            infov 'Package cache path', source_package.path
            infov 'Package size', source_package.path.size
          end

          # @return [EacFs::CachedDownload]
          memoize def source_package
            ::EacFs::CachedDownload.new(url, fs_cache)
          end
        end
      end
    end
  end
end
