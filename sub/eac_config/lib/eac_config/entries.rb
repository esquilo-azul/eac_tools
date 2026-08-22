# frozen_string_literal: true

module EacConfig
  class Entries
    enable_memoized
    common_constructor :root_node, :path do
      self.path = ::EacConfig::EntryPath.assert(path)
    end

    def to_s
      "#{self.class}[RootNode: #{root_node}, Path: #{path}]"
    end

    # @return [Array<EacConfig::Entries>]
    memoize def node_entries
      node_entries_from_root + node_entries_from_load_path
    end

    # @return [Array<EacConfig::Entries>]
    memoize def node_entries_from_load_path
      root_node.recursive_loaded_nodes.flat_map { |loaded_node| loaded_node.self_entries(path) }
    end

    # @return [Array<EacConfig::Entries>]
    memoize def node_entries_from_root
      root_node.self_entries(path)
    end
  end
end
