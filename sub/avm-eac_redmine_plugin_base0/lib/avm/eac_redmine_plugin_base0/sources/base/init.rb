# frozen_string_literal: true

require 'avm/eac_redmine_plugin_base0/sources/init_file'
require 'avm/eac_ruby_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        module Init
          INIT_SUBPATH = 'init.rb'

          # @return [Avm::EacRedminePluginBase0::Sources::InitFile]
          def init_file
            ::Avm::EacRedminePluginBase0::Sources::InitFile.new(init_path)
          end

          # @return [String]
          def init_path
            path.join(INIT_SUBPATH)
          end
        end
      end
    end
  end
end
