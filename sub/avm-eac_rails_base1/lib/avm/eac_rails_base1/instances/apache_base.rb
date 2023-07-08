# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase1
    module Instances
      module ApacheBase
        def document_root
          "#{instance.read_entry(::Avm::Instances::EntryKeys::INSTALL_PATH)}/public"
        end
      end
    end
  end
end
