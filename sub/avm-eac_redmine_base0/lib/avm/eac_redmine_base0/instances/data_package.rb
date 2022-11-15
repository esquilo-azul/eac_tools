# frozen_string_literal: true

require 'avm/instances/data/package'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedmineBase0
    module Instances
      class DataPackage < ::Avm::Instances::Data::Package
        after_load :run_installer

        def initialize(instance, options = {})
          super(instance, options.merge(units: options[:units].if_present({}).merge(
            database: instance.database_unit, files: instance.files_data_unit,
            gitolite: instance.gitolite_data_unit
          )))
        end

        delegate :run_installer, to: :instance
      end
    end
  end
end
