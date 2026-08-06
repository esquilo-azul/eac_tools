# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        module Install
          INSTALL_EXTRA_KEY = 'install.extra'
          DEFAULT_INSTALL_EXTRA = ''

          # @return [String]
          def auto_install_extra
            inherited_entry_value(::Avm::Instances::EntryKeys::INSTALL_ID, INSTALL_EXTRA_KEY) ||
              DEFAULT_INSTALL_EXTRA
          end

          def run_installer
            ::EacRubyUtils::Ruby.on_clean_environment do
              installer_command.system!
            end
          end

          def installer_command
            host_env.command(installer_path, install_task)
          end

          def installer_path
            ::File.join(install_path, 'plugins', 'redmine_installer', 'installer',
                        'run.sh')
          end

          def install_task
            if web_path_optional.present?
              'redmine_as_apache_path'
            else
              'redmine_as_apache_base'
            end
          end
        end
      end
    end
  end
end
