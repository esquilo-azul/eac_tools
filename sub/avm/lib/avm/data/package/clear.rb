# frozen_string_literal: true

require 'avm/data/package/base_performer'

module Avm
  module Data
    class Package
      class Clear < ::Avm::Data::Package::BasePerformer
        enable_method_class

        # @return [void]
        def result
          selected_units.each do |identifier, unit|
            infov 'Clearing unit', identifier
            unit.clear
          end
        end
      end
    end
  end
end
