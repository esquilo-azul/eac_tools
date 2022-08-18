# frozen_string_literal: true

require 'avm/eac_webapp_base0/apache_host'

module Avm
  module EacWordpressBase0
    module Instances
      class ApacheHost < ::Avm::EacWebappBase0::ApacheHost
        def document_root
          instance.read_entry(::Avm::Instances::EntryKeys::INSTALL_PATH)
        end

        def extra_content
          "AssignUserID #{system_user} #{system_group}"
        end

        def system_user
          instance.install_username
        end

        def system_group
          instance.install_groupname
        end
      end
    end
  end
end
