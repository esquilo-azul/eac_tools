# frozen_string_literal: true

module EacConfig
  class OldConfigs
    class Base
      enable_memoized

      common_constructor :data, default: [{}] do
        self.data = ::EacConfig::PathsHash.new(data)
      end

      def []=(entry_key, entry_value)
        write(entry_key, entry_value)
      end

      def [](entry_key)
        read(entry_key)
      end

      def clear
        replace({})
      end

      def read(entry_key)
        return nil unless data.key?(entry_key)

        data.fetch(entry_key).if_present(::EacRubyUtils::BlankNotBlank.instance)
      end

      def replace(new_data)
        self.data = ::EacConfig::PathsHash.new(new_data)
      end

      def write(entry_key, entry_value)
        data[entry_key] = entry_value
      end
    end
  end
end
