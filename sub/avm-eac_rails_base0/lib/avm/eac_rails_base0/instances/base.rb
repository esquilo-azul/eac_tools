# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/base'
require 'avm/eac_rails_base0/instances/deploy'

module Avm
  module EacRailsBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        UPLOADS_UNIT_SUBPATH = 'public/uploads'

        # @return [Avm::Instances::Data::Package]
        def data_package_create
          super.add_unit('uploads', uploads_unit)
        end

        # @return [Avm::Instances::Data::FilesUnit]
        def uploads_unit
          ::Avm::Instances::Data::FilesUnit.new(self, UPLOADS_UNIT_SUBPATH)
        end
      end
    end
  end
end
