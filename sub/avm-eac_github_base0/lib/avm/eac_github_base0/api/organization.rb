# frozen_string_literal: true

require 'avm/eac_github_base0/api/entity'
require 'avm/eac_github_base0/api/repository'
require 'eac_rest/api'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGithubBase0
    class Api < ::EacRest::Api
      class Organization < ::Avm::EacGithubBase0::Api::Entity
        # @return [Array<Avm::EacGithubBase0::Api::Repository>]
        def repositories
          all_from_list(::Avm::EacGithubBase0::Api::Repository, "/orgs/#{id}/repos")
        end
      end
    end
  end
end
