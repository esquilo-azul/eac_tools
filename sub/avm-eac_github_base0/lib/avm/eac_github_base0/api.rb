# frozen_string_literal: true

require 'eac_rest/api'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGithubBase0
    class Api < ::EacRest::Api
      DEFAULT_ROOT_URL = 'https://api.github.com'

      def initialize(root_url = DEFAULT_ROOT_URL)
        super(root_url)
      end

      require_sub __FILE__
    end
  end
end
