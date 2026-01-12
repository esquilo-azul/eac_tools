# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'avm/instances/entry_keys'

module Avm
  module EacWebappBase0
    module Instances
      class Base < ::Avm::Instances::Base
        module Install
          common_concern do
            uri_components_entries_values 'install', %w[apache_resource_name]
          end

          def install_apache_resource_name_default_value
            id
          end
        end
      end
    end
  end
end
