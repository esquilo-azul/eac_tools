# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedmineBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        module Gitolite
          GITOLITE_ENTRY_KEYS_PREFIX = 'gitolite'
          DEFAULT_HOSTNAME = 'localhost'
          DEFAULT_PATH_PARENT = '/var/lib'
          DEFAULT_SCHEME = 'file'
          DEFAULT_USERNAME = 'git'

          common_concern do
            uri_components_entries_values GITOLITE_ENTRY_KEYS_PREFIX
          end

          def gitolite_hostname_default_value
            DEFAULT_HOSTNAME
          end

          def gitolite_path_default_value
            read_entry_optional([GITOLITE_ENTRY_KEYS_PREFIX, 'username']).if_present do |v|
              ::File.join(DEFAULT_PATH_PARENT, v)
            end
          end

          def gitolite_scheme_default_value
            DEFAULT_SCHEME
          end

          def gitolite_username_default_value
            DEFAULT_USERNAME
          end
        end
      end
    end
  end
end
