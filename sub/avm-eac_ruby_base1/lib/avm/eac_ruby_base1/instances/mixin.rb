# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacRubyBase1
    module Instances
      module Mixin
        DEFAULT_RUBY_VERSION = '2.7.7'
        RUBY_VERSION_KEY = 'ruby.version'

        def auto_ruby_version
          inherited_entry_value(::Avm::Instances::EntryKeys::INSTALL_ID, RUBY_VERSION_KEY) ||
            DEFAULT_RUBY_VERSION
        end
      end
    end
  end
end
