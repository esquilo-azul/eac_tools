# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/entries/entry'

module Avm
  module Entries
    module Base
      require_sub __FILE__, require_dependency: true
      common_concern

      module ClassMethods
        def uri_components_entries_values(prefix, extra_fields = [])
          ::Avm::Entries::Base::UriComponentsEntriesValues.new(self, prefix, extra_fields).result
        end
      end

      def entries_provider_id
        id
      end

      def entry(suffix, options = {})
        ::Avm::Entries::Entry.new(self, suffix, options)
      end

      def path_prefix
        @path_prefix ||= [entries_provider_id].freeze
      end

      def read_entry(entry_suffix, options = {})
        entry(entry_suffix, options).value
      end

      def read_entry_optional(entry_suffix, options = {})
        entry(entry_suffix, options).optional_value
      end

      def full_entry_path(entry_suffix)
        unless entry_suffix.is_a?(::Array)
          entry_suffix = ::EacConfig::PathsHash.parse_entry_key(entry_suffix.to_s)
        end
        (path_prefix + entry_suffix).join('.')
      end
    end
  end
end
