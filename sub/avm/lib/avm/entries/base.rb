# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/entries/entry'

module Avm
  module Entries
    module Base
      def entry(suffix, options = {})
        ::Avm::Entries::Entry.new(self, suffix, options)
      end

      def path_prefix
        @path_prefix ||= [id].freeze
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

      def inherited_entry_value(source_entry_suffix, target_entry_suffix, &block)
        read_entry_optional(source_entry_suffix).if_present do |instance_id|
          other_entry_value(instance_id, target_entry_suffix).if_present(&block)
        end
      end

      def other_entry_value(instance_id, entry_suffix)
        ::Avm::Instances::Base.by_id(instance_id).read_entry_optional(entry_suffix)
      end
    end
  end
end
