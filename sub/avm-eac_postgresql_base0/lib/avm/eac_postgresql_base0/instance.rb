# frozen_string_literal: true

require 'avm/eac_postgresql_base0/instance/data_unit'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacPostgresqlBase0
    class Instance
      require_sub __FILE__, include_modules: true

      DEFAULT_HOSTNAME = '127.0.0.1'
      DEFAULT_PORT = 5432
      DEFAULT_SCHEMA = 'public'
      MAINTENANCE_DATABASE = 'postgres'

      common_constructor :env, :connection_params do
        self.connection_params = connection_params.with_indifferent_access
      end

      def assert
        ::Avm::EacPostgresqlBase0::Instance::Assert.new(self).perform
      end

      def data_unit
        ::Avm::EacPostgresqlBase0::Instance::DataUnit.new(self)
      end

      def host
        connection_params[:host] || DEFAULT_HOSTNAME
      end

      def port
        connection_params[:port] || DEFAULT_PORT
      end

      def user
        connection_params.fetch(:user)
      end

      def password
        connection_params.fetch(:password)
      end

      def name
        connection_params.fetch(:name)
      end

      def schema
        connection_params[:schema] || DEFAULT_SCHEMA
      end
    end
  end
end
