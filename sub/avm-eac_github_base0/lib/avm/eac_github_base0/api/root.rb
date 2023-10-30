# frozen_string_literal: true

require 'avm/eac_github_base0/api/entity'
require 'avm/eac_github_base0/api/organization'
require 'eac_rest/api'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGithubBase0
    class Api < ::EacRest::Api
      class Root < ::Avm::EacGithubBase0::Api::Entity
        # @param id [String]
        # @return [Avm::EacGithubBase0::Api::Organization]
        def organization(id)
          child_entity(::Avm::EacGithubBase0::Api::Organization, id)
        end
      end
    end
  end
end
