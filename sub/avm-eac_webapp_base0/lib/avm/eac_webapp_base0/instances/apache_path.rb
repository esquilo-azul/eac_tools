# frozen_string_literal: true

require 'avm/entries/jobs/base'
require 'avm/eac_ubuntu_base0/apache'
require 'avm/eac_webapp_base0/instances/apache_base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacWebappBase0
    module Instances
      class ApachePath < ::Avm::EacWebappBase0::Instances::ApacheBase
        JOBS = %w[write_available_conf enable_conf reload_apache].freeze
        include ::Avm::Entries::Jobs::Base

        def content
          ::Avm::EacWebappBase0::Instances::ApachePath.template.child('default.conf')
                                                      .apply(variables_source)
        end

        def extra_content
          ''
        end

        private

        def enable_conf
          infom 'Enabling configuration...'
          conf.enable
        end

        def conf_uncached
          apache.conf(instance.id)
        end

        def write_available_conf
          infom 'Writing available configuration...'
          conf.write(content)
        end
      end
    end
  end
end
