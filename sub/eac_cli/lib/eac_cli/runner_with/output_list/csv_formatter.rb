# frozen_string_literal: true

require 'csv'

module EacCli
  module RunnerWith
    module OutputList
      class CsvFormatter < ::EacCli::RunnerWith::OutputList::BaseFormatter
        # @return [Array]
        def build_row(row)
          build_columns.map { |c| build_value(row, c) }
        end

        # @return [String]
        def to_output
          ::CSV.generate do |csv|
            csv << build_columns
            build_rows.each { |row| csv << row }
          end
        end
      end
    end
  end
end
