# frozen_string_literal: true

require 'avm/instances/data/unit'

module Avm
  module EacPostgresqlBase0
    class Instance
      class DataUnit < ::Avm::Instances::Data::Unit
        EXTENSION = '.pgdump.gz'
        SCHEMA_VAR = '%%SCHEMA%%'
        TABLE_PARTS_SEPARATOR = '/'
        TABLES_SQL = "select schemaname || '#{TABLE_PARTS_SEPARATOR}' || tablename from " \
          "pg_tables where schemaname = '#{SCHEMA_VAR}'"

        before_load :clear

        def clear
          info 'Clearing database (Dropping all tables)...'
          ts = tables
          if ts.empty?
            info 'Database has no tables'
          else
            info "Removing #{ts.count} table(s)..."
            run_sql(drop_tables_sql(ts))
          end
        end

        def dump_command
          instance.pg.dump_gzip_command
        end

        def load_command
          instance.pg.load_gzip_command
        end

        private

        # @param table_list [Array<String>]
        # @return [String]
        def drop_tables_sql(table_list)
          'drop table ' + table_list.map(&:to_s).join(', ') + ' cascade'
        end

        # @param parts [Array<String>, Strings]
        # @return [String]
        def join_table_parts(parts)
          parts = parts.to_s.split(TABLE_PARTS_SEPARATOR) unless parts.is_a?(::Enumerable)
          parts.map { |p| "\"#{p}\"" }.join('.')
        end

        def run_sql(sql)
          instance.pg.psql_command_command(sql).execute!
        end

        # @return [Array<String>]
        def tables
          run_sql(tables_sql).each_line.map(&:strip).reject(&:blank?)
                             .map { |line| join_table_parts(line) }
        end

        # @return [String]
        def tables_sql
          TABLES_SQL.gsub(SCHEMA_VAR, instance.pg.schema)
        end
      end
    end
  end
end
