# frozen_string_literal: true

require 'avm/instances/entry_keys'
require 'avm/eac_webapp_base0/instances/base'

module Avm
  module EacWordpressBase0
    module Instances
      class Base < ::Avm::EacWebappBase0::Instances::Base
        THEMES_UNIT_SUBPATH = 'wp-content/themes'
        UPLOADS_UNIT_SUBPATH = 'wp-content/uploads'
        FILES_UNITS = { uploads: UPLOADS_UNIT_SUBPATH, themes: THEMES_UNIT_SUBPATH }.freeze

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

        # @return [Avm::Instances::Data::FilesUnit]
        def themes_unit
          ::Avm::Instances::Data::FilesUnit.new(self, THEMES_UNIT_SUBPATH)
        end

        # @return [Avm::Instances::Data::FilesUnit]
        def uploads_unit
          ::Avm::Instances::Data::FilesUnit.new(self, UPLOADS_UNIT_SUBPATH)
        end
      end
    end
  end
end
