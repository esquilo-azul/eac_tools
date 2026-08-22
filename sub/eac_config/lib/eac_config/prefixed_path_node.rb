# frozen_string_literal: true

module EacConfig
  class PrefixedPathNode
    include ::EacConfig::Node

    common_constructor :from_node, :path_prefix do
      self.path_prefix = ::EacConfig::EntryPath.assert(path_prefix)
    end

    def entry(path)
      ::EacConfig::Entry.new(self, path)
    end
  end
end
