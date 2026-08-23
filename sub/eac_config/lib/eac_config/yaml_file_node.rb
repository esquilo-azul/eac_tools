# frozen_string_literal: true

require 'addressable'

module EacConfig
  class YamlFileNode
    include ::EacConfig::Node

    enable_memoized

    class << self
      def from_uri(uri)
        new(uri.to_addressable.path) if uri.to_addressable.scheme == 'file'
      end
    end

    common_constructor :path do
      self.path = path.to_pathname
    end
    compare_by :path

    memoize def data
      r = nil
      if path.file?
        r = ::EacRubyUtils::Yaml.load_file(path)
      elsif path.exist?
        raise("\"#{path}\" is a not a file")
      end

      r.is_a?(::Hash) ? r : {}
    end

    def persist_data(new_data)
      path.parent.mkpath
      ::EacRubyUtils::Yaml.dump_file(path, new_data)
      unmemoize(:data)
    end

    def url
      ::Addressable::URI.parse("file://#{path.expand_path}")
    end

    def to_s
      "#{self.class}[#{path}]"
    end

    require_sub __FILE__, require_mode: :kernel
  end
end
