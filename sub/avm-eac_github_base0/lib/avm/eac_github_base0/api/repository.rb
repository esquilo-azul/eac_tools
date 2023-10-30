# frozen_string_literal: true

require 'avm/eac_github_base0/api/entity'
require 'eac_rest/api'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGithubBase0
    class Api < ::EacRest::Api
      class Repository < ::Avm::EacGithubBase0::Api::Entity
      end
    end
  end
end
