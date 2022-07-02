# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    module EntryKeys
      class << self
        def all
          all_keys.to_a
        end

        def keys_consts_set(prefix, suffixes)
          if suffixes.is_a?(::Hash)
            keys_consts_set_from_hash(prefix, suffixes)
          elsif suffixes.is_a?(::Enumerable)
            keys_consts_set_from_enum(prefix, suffixes)
          else
            raise "Unmapped suffixes class: #{suffixes.class}"
          end
        end

        def key_const_set(prefix, suffix)
          key = [prefix, suffix].reject(&:blank?).join('.')
          const_set(key.gsub('.', '_').upcase, key)
          all_keys << key
        end

        private

        def all_keys
          @all_keys ||= ::Set.new
        end

        def keys_consts_set_from_enum(prefix, suffixes)
          suffixes.each { |suffix| key_const_set(prefix, suffix) }
        end

        def keys_consts_set_from_hash(prefix, suffixes)
          suffixes.each { |k, v| keys_consts_set(prefix.to_s + (k.blank? ? '' : ".#{k}"), v) }
        end
      end

      {
        '' => %w[data_fs_path fs_path host_id name source_instance_id],
        admin: %w[username password api_key],
        database: %w[id hostname limit name password port system timeout username extra],
        docker: %w[registry],
        fs: %w[url],
        mailer: {
          '' => %w[id from reply_to],
          smtp: %w[address port domain username password authentication openssl_verify_mode
                   starttls_auto tls]
        },
        ssh: %w[hostname port url username],
        web: %w[authority hostname path port scheme url userinfo]
      }.each { |prefix, suffixes| keys_consts_set(prefix, suffixes) }
    end
  end
end
