# frozen_string_literal: true

module Avm
  module EacRedminePluginBase0
    module Sources
      class InitFile
        common_constructor :path

        VERSION_LINE_PATTERN = /\A(\s*)version\s*['"]([^'"]+)['"](\s*)\z/

        # @param new_value [String]
        def version=(new_value)
          version_set(new_value)
        end

        require_sub __FILE__, require_mode: :kernel
      end
    end
  end
end
