# frozen_string_literal: true

module EacConfig
  class YamlFileNode
    class Entry < ::EacConfig::NodeEntry
      enable_memoized

      def found?
        paths_hash.key?(to_paths_hash_key)
      end

      def value
        paths_hash[to_paths_hash_key]
      end

      def value=(a_value)
        node.persist_data(paths_hash.write(to_paths_hash_key, a_value).root.to_h)
      end

      private

      # @return [EacConfig::PathsHash]
      def paths_hash
        ::EacConfig::PathsHash.new(node.data)
      end

      def to_paths_hash_key
        path.parts.join('.')
      end
    end
  end
end
