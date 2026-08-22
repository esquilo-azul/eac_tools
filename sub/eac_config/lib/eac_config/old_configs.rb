# frozen_string_literal: true

require 'active_support/core_ext/string'
require 'yaml'

module EacConfig
  # @deprecated Use {EacConfig::YamlFileNode} instead.
  class OldConfigs
    enable_memoized

    attr_reader :configs_key, :options

    # Valid options: [:storage_path]
    def initialize(configs_key, options = {})
      @configs_key = configs_key
      @options = options.to_sym_keys_hash.freeze
      load
    end

    delegate :clear, to: :file

    delegate :save, to: :file

    delegate :load, to: :file

    def []=(entry_key, entry_value)
      write_entry(entry_key, entry_value)
    end

    def write_entry(entry_key, entry_value)
      file.write(entry_key, entry_value)
    end

    def [](entry_key)
      read_entry(entry_key)
    end

    memoize def file
      ::EacConfig::OldConfigs::File.new(
        storage_path, options
      )
    end

    def read_entry(entry_key)
      file.read(entry_key)
    end

    memoize def storage_path
      path = options_storage_path || default_storage_path
      return path if ::File.exist?(path) && ::File.size(path).positive?

      ::FileUtils.mkdir_p(::File.dirname(path))
      ::File.write(path, {}.to_yaml)
      path
    end

    delegate :autosave?, to: :file

    private

    attr_accessor :data

    def options_storage_path
      options[:storage_path]
    end

    def default_storage_path
      ::File.join(Dir.home, '.config', configs_key, 'settings.yml')
    end
  end
end
