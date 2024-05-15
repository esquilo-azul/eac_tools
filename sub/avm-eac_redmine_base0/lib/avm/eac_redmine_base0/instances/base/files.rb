# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/base'
require 'avm/instances/data/files_unit'
require 'eac_ruby_utils/core_ext'

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
