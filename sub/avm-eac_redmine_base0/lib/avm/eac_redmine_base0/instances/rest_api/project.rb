# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class RestApi < ::EacRest::Api
        class Project < ::Avm::EacRedmineBase0::Instances::RestApi::EntityBase
          # @return [String]
          def prefix
            "/projects/#{id}"
          end

          # @return [Avm::EacRedmineBase0::Instances::RestApi::WikiPage]
          def wiki_page(name)
            child_entity(::Avm::EacRedmineBase0::Instances::RestApi::WikiPage, name)
          end
        end
      end
    end
  end
end
