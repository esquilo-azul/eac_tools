# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Rubocop
      class OffenseSet
        class Offense
          class << self
            def by_data(data)
              new(data)
            end
          end

          common_constructor :data

          # @return [String]
          def cop_name
            data.fetch('cop_name')
          end

          # @return [Integer]
          def line_index
            line_number - 1
          end

          # @return [Integer]
          def line_number
            data.fetch('location').fetch('line')
          end
        end
      end
    end
  end
end
