# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class RestApi < ::EacRest::Api
        class Root < ::Avm::EacRedmineBase0::Instances::RestApi::EntityBase
          # @param id_or_identifier [String]
          # @return [Avm::EacRedmineBase0::Instances::RestApi::Project]
          def project(id_or_identifier)
            api.entity(::Avm::EacRedmineBase0::Instances::RestApi::Project, id_or_identifier)
          end
        end
      end
    end
  end
end
