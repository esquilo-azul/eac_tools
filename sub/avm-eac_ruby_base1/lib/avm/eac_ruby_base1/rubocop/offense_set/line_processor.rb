# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Rubocop
      class OffenseSet
        class LineProcessor
          LINE_STRUCT = ::Struct.new(:left, :right)
          LINE_PATTERN = /\A(.+)(?:\#\s*rubocop:disable\s*(.+))?\z/

          enable_simple_cache
          common_constructor :line, :offenses

          def result
            r = line_left
            r += " # rubocop:disable #{all_cops.join(',')}" if all_cops.any?
            "#{r}\n"
          end

          private

          # @return [Array<String>]
          def all_cops_uncached
            (current_cops + offenses_cops).uniq.sort
          end

          # @return [Array<String>]
          def current_cops
            parsed_line[1].if_present([]) { |s| s.split(',').map(&:strip).select(&:present) }
          end

          # @return [Array<String>]
          def offenses_cops
            offenses.map(&:cop_name)
          end

          def line_left
            parsed_line[0]
          end

          # @return [LINE_STRUCT]
          def parsed_line_uncached
            m = LINE_PATTERN.match(line)
            if m
              LINE_STRUCT.new(m[1].rstrip, m[2].rstrip)
            else
              LINE_STRUCT.new(line.rstrip, nil)
            end
          end
        end
      end
    end
  end
end
