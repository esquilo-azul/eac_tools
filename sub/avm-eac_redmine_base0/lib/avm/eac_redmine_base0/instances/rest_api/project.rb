# frozen_string_literal: true

require 'avm/eac_redmine_base0/instances/rest_api/entity_base'
require 'avm/eac_redmine_base0/instances/rest_api/wiki_page'
require 'eac_rest/api'
require 'eac_ruby_utils/core_ext'

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
