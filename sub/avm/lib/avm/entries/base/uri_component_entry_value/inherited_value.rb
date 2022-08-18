# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'eac_config/entry_path'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Base
      class UriComponentEntryValue
        class InheritedValue
          enable_method_class
          common_constructor :uri_component_entry_value
          delegate :component, :entries_provider, :id_entry_path, :component_entry_path,
                   to: :uri_component_entry_value

          def result
            entries_provider.inherited_entry_value(
              id_entry_path.to_string,
              component_entry_path.to_string,
              &inherited_value_block
            )
          end

          def inherited_value_block
            return nil unless entries_provider.respond_to?(inherited_value_block_method_name)

            ->(value) { entries_provider.send(inherited_value_block_method_name, value) }
          end

          def inherited_value_block_method_name
            "#{component}_inherited_value_proc".to_sym
          end
        end
      end
    end
  end
end
