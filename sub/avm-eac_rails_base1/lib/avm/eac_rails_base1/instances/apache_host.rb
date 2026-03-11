# frozen_string_literal: true

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
