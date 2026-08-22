# frozen_string_literal: true

module EacConfig
  module Node
    include ::Memoized

    class << self
      def context
        @context ||= ::EacRubyUtils::Context.new
      end
    end

    attr_accessor :write_node

    common_concern do
      acts_as_abstract :self_entries
      include ::Comparable
    end

    # @return [Array<EacConfig::Entries>]
    def entries(path)
      ::EacConfig::Entries.new(self, path)
    end

    def entry(path)
      ::EacConfig::Entry.new(self, path)
    end

    # @return [[EacConfig::IncludePath]]
    def load_path
      @load_path ||= ::EacConfig::LoadPath.new(self)
    end

    # @return [Addressable::URI]
    def url
      raise_abstract_method(__method__)
    end

    # Return a entry which search values only in the self node.
    # @return [EacConfig::NodeEntry]
    def self_entry(path)
      self_entry_class.new(self, path)
    end

    def self_entry_class
      self.class.const_get('Entry')
    end

    # @return [Array<EacConfig::Node>]
    def self_loaded_nodes
      load_path.paths.flat_map { |node_path| load_nodes(node_path) }
    end

    # @return [Array<EacConfig::Node>]
    memoize def recursive_loaded_nodes
      ::EacConfig::LoadNodesSearch.new(self).result
    end

    # @return [EacConfig::PrefixedPathNode]
    def with_prefix(path_prefix)
      ::EacConfig::PrefixedPathNode.new(self, path_prefix)
    end

    private

    # @param node_path [String]
    # @return [Array<EacConfig::Node>]
    def load_nodes(node_path)
      ::EacConfig::NodeUri.new(node_path, url).instanciate
    end
  end
end
