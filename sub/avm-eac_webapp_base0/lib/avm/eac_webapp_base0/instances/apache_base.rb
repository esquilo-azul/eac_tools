# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      class ApacheBase
        # @return [String]
        def document_root
          instance.read_entry(::Avm::Instances::EntryKeys::INSTALL_PATH)
        end

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
