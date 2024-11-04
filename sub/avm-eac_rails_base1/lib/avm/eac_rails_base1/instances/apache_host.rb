# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/apache_base'
require 'avm/eac_webapp_base0/instances/apache_host'

module Avm
  module EacRailsBase1
    module Instances
      class ApacheHost < ::Avm::EacWebappBase0::Instances::ApacheHost
        prepend ::Avm::EacRailsBase1::Instances::ApacheBase

        def extra_content
          'PassengerEnabled On'
        end
      end
    end
  end
end
