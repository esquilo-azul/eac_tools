# frozen_string_literal: true

require 'avm/instances/base'

module Avm
  module EacWebappBase0
    module Instances
      class Base < ::Avm::Instances::Base
        module Deploy
          common_concern

          # @param options [Class<Avm::EacWebappBase0::Instances::Deploy>]
          def deploy_class
            application.stereotype.namespace_module.then do |s|
              s.const_get('Instances').const_get('Deploy')
            rescue ::NameError
              s.const_get('Deploy')
            end
          end

          # @param options [Hash]
          # return [Avm::EacWebappBase0::Instances::Deploy]
          def deploy_instance(**options)
            deploy_class.new(self, options)
          end
        end
      end
    end
  end
end
