# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/base'

module Avm
  module EacRailsBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        FILES_UNITS = { uploads: 'public/uploads' }.freeze
      end
    end
  end
end
