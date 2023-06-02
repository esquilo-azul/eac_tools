# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/entries/jobs/base'
require 'avm/eac_ubuntu_base0/apache'
require 'eac_templates/core_ext'

module Avm
  module EacWebappBase0
    module Instances
      class ApacheBase
        protected

        def reload_apache
          infom 'Reloading Apache...'
          apache.service('reload')
        end

        private

        # @return [Avm::EacUbuntuBase0::Apache]
        def apache_uncached
          instance.platform_instance.apache
        end
      end
    end
  end
end
