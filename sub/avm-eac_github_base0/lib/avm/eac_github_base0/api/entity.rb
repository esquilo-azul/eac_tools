# frozen_string_literal: true

require 'eac_rest/api'
require 'eac_rest/entity'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGithubBase0
    class Api < ::EacRest::Api
      class Entity < ::EacRest::Entity
        def all_from_list(entity_class, url_suffix)
          r = []
          while url_suffix.present?
            response = api.request_json(url_suffix).response
            r += response.body_data_or_raise
                         .map { |child_data| child_entity(entity_class, child_data) }
            url_suffix = response.link('next')
          end
          r
        end
      end
    end
  end
end
