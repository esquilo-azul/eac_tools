# frozen_string_literal: true

module EacConfig
  class PrefixedPathNode
    class Entry < ::EacConfig::NodeEntry
      enable_memoized
      delegate :found?, :found_node, :secret_value, :value, :value=, :writ_node, to: :full_entry

      # @return [EacConfig::EntryPath]
      def full_path
        node.path_prefix + path
      end

      private

      # @return [EacConfig::NodeEntry]
      memoize def full_entry
        node.from_node.entry(full_path)
      end
    end
  end
end
