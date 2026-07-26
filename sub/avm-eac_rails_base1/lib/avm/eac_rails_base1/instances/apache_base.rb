# frozen_string_literal: true

module Avm
  module EacRailsBase1
    module Instances
      module ApacheBase
        # @return [String]
        def document_root
          ::File.join(super, 'public')
        end
      end
    end
  end
end
