# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/apache_base'
require 'avm/eac_webapp_base0/instances/apache_path'
require 'eac_templates/core_ext'

module Avm
  module EacRailsBase1
    module Instances
      class ApachePath < ::Avm::EacWebappBase0::Instances::ApachePath
        prepend ::Avm::EacRailsBase1::Instances::ApacheBase

        # @return [String]
        def extra_content
          ::Avm::EacRailsBase1::Instances::ApachePath.template.child('extra_content.conf')
            .apply(variables_source)
        end
      end
    end
  end
end
