# frozen_string_literal: true

require 'avm/instances/data/unit'

module Avm
  module EacPostgresqlBase0
    class Instance
      class DataUnit < ::Avm::Instances::Data::Unit
        EXTENSION = '.pgdump.gz'
        TABLES_SQL = 'select tablename from pg_tables where schemaname = \'public\''

        before_load :clear_database

        def dump_command
          instance.dump_gzip_command
        end

        def load_command
          instance.load_gzip_command
        end

        private

        def clear_database
          info 'Clearing database (Dropping all tables)...'
          ts = tables
          if ts.empty?
            info 'Database has no tables'
          else
            info "Removing #{ts.count} table(s)..."
            run_sql('drop table if exists ' + ts.map { |t| "\"#{t}\"" }.join(', ') + ' cascade')
          end
        end

        def run_sql(sql)
          instance.psql_command_command(sql).execute!
        end

        # @return [Array<String>]
        def tables
          run_sql(tables_sql).each_line.map(&:strip).reject(&:blank?)
        end

        # @return [String]
        def tables_sql
          TABLES_SQL
        end
      end
    end
  end
end
