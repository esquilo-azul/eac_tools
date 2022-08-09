# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'avm/eac_webapp_base0/instance'

module Avm
  module EacRailsBase1
    module Instances
      class Base < ::Avm::EacWebappBase0::Instance
        DEFAULT_RAILS_ENVIRONMENT = 'production'

        def bundle(*args)
          the_gem.bundle(*args).chdir_root.envvar('RAILS_ENV', DEFAULT_RAILS_ENVIRONMENT)
        end

        def rake(*args)
          bundle('exec', 'rake', *args)
        end

        def the_gem
          @the_gem ||= ::Avm::EacRubyBase1::Sources::Base.new(::File.join(read_entry('fs_path')))
                         .env_set(host_env)
        end
      end
    end
  end
end
