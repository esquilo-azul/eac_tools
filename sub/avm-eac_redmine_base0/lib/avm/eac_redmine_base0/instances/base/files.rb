# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        module Files
          FILES_SUBPATH = 'files'

          # @return [Avm::Instances::Data::FilesUnit]
          def files_data_unit
            ::Avm::Instances::Data::FilesUnit.new(self, FILES_SUBPATH)
          end
        end
      end
    end
  end
end
