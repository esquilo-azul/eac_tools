# frozen_string_literal: true

require 'avm/instances/entry_keys'
require 'avm/eac_postgresql_base0/instance'

module Avm
  module EacPostgresqlBase0
    module InstanceWith
      def pg
        @pg ||= ::Avm::EacPostgresqlBase0::Instance.new(
          host_env, user: database_username,
                    password: database_password,
                    name: database_name
        )
      end
    end
  end
end
