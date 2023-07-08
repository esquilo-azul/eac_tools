# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/acts_as_abstract'

module EacCli
  module RunnerWith
    module OutputList
      class BaseFormatter
        acts_as_abstract :to_output
        common_constructor :columns, :rows

        # @return [String]
        def build_column(column)
          column.to_s
        end

        # @return [Array<String>]
        def build_columns
          columns.map(&:to_s)
        end

        # @return [Array<Hash<String, String>>]
        def build_rows
          rows.map { |row| build_row(row) }
        end
      end
    end
  end
end
