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

        def run_subcommand(subcommand_class, argv)
          subcommand_class.create(
            argv: argv,
            parent: ::Avm::Instances::Base::SubcommandParent.new(self)
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
          pg_data_unit
        end

        private

        # @return [Avm::EacUbuntuBase0::Instances::Base]
        def platform_instance_uncached
          ::Avm::EacUbuntuBase0::Instances::Base.by_id(id)
        end
      end
    end
  end
end
