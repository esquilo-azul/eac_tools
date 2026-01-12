# frozen_string_literal: true

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
