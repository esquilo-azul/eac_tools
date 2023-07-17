# frozen_string_literal: true

require 'avm/eac_postgresql_base0/instance/data_unit'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacPostgresqlBase0
    class Instance
      module Commands
        DUMP_EXCLUDE_PATTERNS = ['(CREATE|COMMENT ON) EXTENSION',
                                 'SET default_table_access_method'].freeze

        # @return [EacRubyUtils::Envs::Command]
        def dump_command
          DUMP_EXCLUDE_PATTERNS
            .inject(pg_dump_command) { |a, e| a.pipe(exclude_pattern_command(e)) }
        end

        # @return [EacRubyUtils::Envs::Command]
        def dump_gzip_command
          dump_command.pipe(gzip_compress_command)
        end

        # @return [EacRubyUtils::Envs::Command]
        def gzip_compress_command
          env.command('gzip', '-9', '-c')
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

        def psql_command(database = true)
          env.command(password_command_argument, 'psql', '--variable', 'ON_ERROR_STOP=t',
                      *common_command_args(database))
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

        private

        # @return [EacRubyUtils::Envs::Command]
        def exclude_pattern_command(pattern)
          env.command('sed', '--regexp-extended', "s/(^|\\n)#{pattern}[^;]*;//gm")
        end

        # @return [EacRubyUtils::Envs::Command]
        def pg_dump_command
          env.command('pg_dump', '--no-privileges', '--no-owner', *common_command_args)
             .envvar('PGPASSWORD', password)
        end
      end
    end
  end
end
