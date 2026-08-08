# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Rubocop
      class OffenseSet
        class << self
          # @param json_text [String] The output of `rubocop --format json`.
          # @return [Avm::EacRubyBase1::Rubocop::OffenseSet]
          def from_json(json_text)
            new(
              JSON.parse(json_text).fetch('files').map do |data|
                ::Avm::EacRubyBase1::Rubocop::OffenseSet::File.by_data(data)
              end.select(&:offenses?)
            )
          end
        end

        common_constructor :files

        # @return [void]
        def disable_all
          files.each(&:disable_offenses)
        end
      end
    end
  end
end
