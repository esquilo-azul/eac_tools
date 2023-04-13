# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/eac_postgresql_base0/instance_with'
require 'avm/instances/data/files_unit'
require 'avm/instances/data/package'
require 'avm/eac_webapp_base0/instances/runners'
require 'avm/eac_ubuntu_base0/instances/base'

module Avm
  module EacWebappBase0
    module Instances
      class Base < ::Avm::Instances::Base
        require_sub __FILE__
        include ::Avm::EacPostgresqlBase0::InstanceWith
        enable_simple_cache

        FILES_UNITS = [].freeze

        def data_dump(argv = [])
          run_subcommand(data_dump_runner_class, argv)
        end

        def data_dump_runner_class
          ::Avm::EacWebappBase0::Instances::Runners::Data::Dump
        end

        def run_subcommand(subcommand_class, argv)
          subcommand_class.create(
            argv: argv,
            parent: ::Avm::EacWebappBase0::Instances::Base::SubcommandParent.new(self)
          ).run
        end

        # @return [Avm::Instances::Data::Package]
        def data_package
          @data_package ||= data_package_create
        end

        # @return [Avm::Instances::Data::Package]
        def data_package_create
          ::Avm::Instances::Data::Package.new(self)
        end

        def database_unit
          pg.data_unit
        end

        private

        # @return [Avm::EacUbuntuBase0::Instances::Base]
        def platform_instance_uncached
          ::Avm::EacUbuntuBase0::Instances::Base.by_id(id)
        end

        def files_units
          self.class.const_get('FILES_UNITS').transform_values do |fs_path_subpath|
            ::Avm::Instances::Data::FilesUnit.new(self, fs_path_subpath)
          end
        end
      end
    end
  end
end
