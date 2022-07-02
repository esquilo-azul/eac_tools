# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacCli
  class OldConfigs
    require_sub __FILE__
    enable_speaker

    class << self
      def entry_key_to_envvar_name(entry_key)
        ::EacCli::OldConfigs::EntryReader.entry_key_to_envvar_name(entry_key)
      end
    end

    attr_reader :configs

    def initialize(configs_key, options = {})
      options.assert_argument(::Hash, 'options')
      @configs = ::EacConfig::OldConfigs.new(configs_key, options.merge(autosave: true))
    end

    def read_password(entry_key, options = {})
      ::EacCli::OldConfigs::PasswordEntryReader.new(self, entry_key, options).read
    end

    def read_entry(entry_key, options = {})
      ::EacCli::OldConfigs::EntryReader.new(self, entry_key, options).read
    end

    def store_passwords?
      ::EacCli::OldConfigs::StorePasswordsEntryReader.new(self) == 'yes'
    end
  end
end
