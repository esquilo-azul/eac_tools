# frozen_string_literal: true

module EacConfig
  # A entry which search values only in the source node.
  class NodeEntry
    enable_abstract_methods
    enable_memoized
    common_constructor :node, :path do
      self.path = ::EacConfig::EntryPath.assert(path)
    end
    compare_by :node, :path

    abstract_methods :found?, :value, :value=

    def secret_value
      value
    end

    # @return [String]
    def to_s
      "#{self.class}[Node: #{node}, Path: #{path}]"
    end
  end
end
