# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/eac_postgresql_base0/instance_with'
require 'avm/instances/data/files_unit'
require 'avm/instances/data/package'
require 'avm/eac_webapp_base0/instances/processes/web_server'
require 'avm/eac_webapp_base0/instances/runners'
require 'avm/eac_ubuntu_base0/instances/base'

module Avm
  module EacWebappBase0
    module Instances
      class Base < ::Avm::Instances::Base
        require_sub __FILE__, include_modules: true
        include ::Avm::EacPostgresqlBase0::InstanceWith
        enable_simple_cache

        def run_subcommand(subcommand_class, argv)
          subcommand_class.create(
            argv: argv,
            parent: ::Avm::Instances::Base::SubcommandParent.new(self)
          ).run
        end

        def database_unit
          pg_data_unit
        end

        # @return [Array<Avm::Instances::Process>]
        def processes
          super + [::Avm::EacWebappBase0::Instances::Processes::WebServer.new(self)]
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
