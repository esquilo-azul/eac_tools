# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Rubocop
      class OffenseSet
        class File
          class << self
            # @param data [Hash]
            # @return [FileOffenses]
            def by_data(data)
              new(data.fetch('path'), data.fetch('offenses').map do |odata|
                ::Avm::EacRubyBase1::Rubocop::OffenseSet::Offense.by_data(odata)
              end)
            end
          end

          common_constructor :path, :offenses do
            self.path = path.to_pathname
          end

          # @return [void]
          def disable_offenses
            path.write(disable_rubocop_content)
          end

          # @return [Boolean]
          def offenses?
            offenses.any?
          end

          private

          # @return [String]
          def disable_rubocop_content
            path.read.each_line.with_index.map do |line, index|
              ::Avm::EacRubyBase1::Rubocop::OffenseSet::LineProcessor
                .new(line, line_offenses(index)).result
            end.join
          end

          # @param index [Integer]
          # @return [Enumerable<Offense>]
          def line_offenses(index)
            offenses.select { |o| o.line_index == index }
          end
        end
      end
    end
  end
end
