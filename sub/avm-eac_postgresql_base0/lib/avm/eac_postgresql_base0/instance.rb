# frozen_string_literal: true

require 'avm/eac_postgresql_base0/instance/data_unit'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacPostgresqlBase0
    class Instance
      require_sub __FILE__

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

      def dump_command
        env.command('pg_dump', '--no-privileges', '--clean', '--no-owner', *common_command_args)
           .envvar('PGPASSWORD', password)
      end

      # @return [EacRubyUtils::Envs::Command]
      def dump_gzip_command
        dump_command.pipe(gzip_compress_command)
      end

      # @return [EacRubyUtils::Envs::Command]
      def gzip_compress_command
        env.command('gzip', '-9', '-c')
      end

      # @return [String]
      def password_command_argument
        "@ESC_PGPASSWORD=#{password}"
      end

      def psql_command(database = true)
        env.command(password_command_argument, 'psql', *common_command_args(database))
      end

      def psql_command_command(sql, database = true)
        psql_command(database).append(['--quiet', '--tuples-only', '--command', sql])
      end

      def root_psql_command(sql = nil)
        args = ['sudo', '-u', 'postgres', 'psql']
        args += ['--quiet', '--tuples-only', '--command', sql] if sql.present?
        env.command(*args)
      end

      def common_command_args(database = true)
        ['--host', host, '--username', user, '--port', port,
         (database ? name : MAINTENANCE_DATABASE)]
      end

      def host
        connection_params[:host] || '127.0.0.1'
      end

      def port
        connection_params[:port] || '5432'
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
    end
  end
end
