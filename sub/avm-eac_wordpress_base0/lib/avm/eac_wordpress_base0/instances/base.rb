# frozen_string_literal: true

require 'avm/instances/entry_keys'
require 'avm/eac_webapp_base0/instances/base'

module Avm
  module EacWordpressBase0
    module Instances
      class Base < ::Avm::EacWebappBase0::Instances::Base
        FILES_UNITS = { uploads: 'wp-content/uploads', themes: 'wp-content/themes' }.freeze

        def database_unit
          web_url = read_entry(::Avm::Instances::EntryKeys::WEB_URL)
          super.after_load do
            info 'Fixing web addresses...'
            run_sql(<<~SQL)
              update wp_options
              set option_value = '#{web_url}'
              where option_name in ('siteurl', 'home')
            SQL
          end
        end
      end
    end
  end
end
