# frozen_string_literal: true

module Avm
  module EacPostgresqlBase0
    class Instance
      module Commands
        # @return [EacRubyUtils::Envs::Command]
        def dump_command
          pg_dump_command
        end

        # @return [EacRubyUtils::Envs::Command]
        def dump_gzip_command
          dump_command
        end

        # @return [EacRubyUtils::Envs::Command]
        def gzip_decompress_command
          env.command('gzip', '-d')
        end

        # @return [EacRubyUtils::Envs::Command]
        def load_gzip_command
          gzip_decompress_command.pipe(psql_command)
        end

        # @return [String]
        def password_command_argument
          "@ESC_PGPASSWORD=#{password}"
        end

        def psql_command(database = true) # rubocop:disable Style/OptionalBooleanParameter
          env.command(password_command_argument, 'psql', '--variable', 'ON_ERROR_STOP=t',
                      *common_command_args(database))
        end

        def psql_command_command(sql, database = true) # rubocop:disable Style/OptionalBooleanParameter
          psql_command(database).append(['--quiet', '--tuples-only', '--command', sql])
        end

        def root_psql_command(sql = nil)
          args = ['sudo', '-u', 'postgres', 'psql']
          args += ['--quiet', '--tuples-only', '--command', sql] if sql.present?
          env.command(*args)
        end

        def common_command_args(database = true) # rubocop:disable Style/OptionalBooleanParameter
          ['--host', host, '--username', user, '--port', port] + database_args(database)
        end

        private

        # @param database [Boolean, String]
        # @return [String]
        def database_args(database)
          [database ? name : MAINTENANCE_DATABASE]
        end

        # @return [EacRubyUtils::Envs::Command]
        def pg_dump_command
          env.command('pg_dump', '--no-privileges', '--no-owner', '--format=custom',
                      *common_command_args).envvar('PGPASSWORD', password)
        end
      end
    end
  end
end
