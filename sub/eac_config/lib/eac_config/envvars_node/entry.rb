# frozen_string_literal: true

module EacConfig
  class EnvvarsNode
    class Entry < ::EacConfig::NodeEntry
      class << self
        def entry_path_to_envvar_name(path)
          ::EacConfig::EntryPath.assert(path).parts.join('_').gsub(/[^a-z0-9_]/i, '')
            .gsub(/\A_+/, '').gsub(/_+\z/, '').gsub(/_{2,}/, '_').upcase
        end

        def from_value(string)
          return nil if string.nil?
          return ::EacRubyUtils::Yaml.load(string) if string.start_with?('---')

          string
        end

        def to_value(object)
          return nil if object.nil?
          return object if object.is_a?(String)

          ::EacRubyUtils::Yaml.dump(object)
        end
      end

      enable_memoized

      def found?
        ENV.key?(envvar_name)
      end

      def value
        self.class.from_value(ENV.fetch(envvar_name, nil))
      end

      def value=(a_value)
        ENV[envvar_name] = self.class.to_value(a_value)
      end

      private

      memoize def envvar_name
        self.class.entry_path_to_envvar_name(path)
      end
    end
  end
end
