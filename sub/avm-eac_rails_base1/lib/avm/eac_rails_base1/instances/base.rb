# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/apache_host'
require 'avm/eac_rails_base1/instances/apache_path'
require 'avm/eac_rails_base1/instances/processes/tasks_scheduler'
require 'avm/eac_rails_base1/instances/runners'
require 'avm/eac_ruby_base1/instances/mixin'
require 'avm/eac_ruby_base1/sources/base'
require 'avm/eac_webapp_base0/instances/base'

module Avm
  module EacRailsBase1
    module Instances
      class Base < ::Avm::EacWebappBase0::Instances::Base
        include ::Avm::EacRubyBase1::Instances::Mixin

        DEFAULT_RAILS_ENVIRONMENT = 'production'

        def bundle(*args)
          the_gem.bundle(*args).chdir_root.envvar('RAILS_ENV', DEFAULT_RAILS_ENVIRONMENT)
        end

        # @return [Avm::Instances::Data::Package]
        def data_package_create
          super.add_unit('database', database_unit)
        end

        # @return [Addressable::URI]
        def gemfile_source
          application.local_source.gemfile_source
        end

        # @return [Array<Avm::Instances::Process>]
        def processes
          super + [::Avm::EacRailsBase1::Instances::Processes::TasksScheduler.new(self)]
        end

        def rake(*args)
          bundle('exec', 'rake', *args)
        end

        def the_gem
          @the_gem ||= ::Avm::EacRubyBase1::Sources::Base.new(
            ::File.join(read_entry('install.path'))
          ).env_set(host_env)
        end
      end
    end
  end
end
