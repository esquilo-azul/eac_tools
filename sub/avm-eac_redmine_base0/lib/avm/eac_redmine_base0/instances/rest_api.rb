# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class RestApi < ::EacRest::Api
        # @return [Addressable::URI]
        def build_service_url(suffix)
          r = super
          r.path = "#{r.path}.json"
          r
        end
      end
    end
  end
end
