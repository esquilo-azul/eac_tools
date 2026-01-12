# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        module Version
          # @return [Avm::VersionNumber]
          def version
            if version_file_path.exist?
              super
            else
              init_file.version
            end
          end

          def version=(value)
            if version_file_path.exist?
              super
            else
              init_file.version = value
            end
          end
        end
      end
    end
  end
end
