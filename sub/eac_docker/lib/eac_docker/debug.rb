# frozen_string_literal: true

require 'eac_ruby_utils/boolean'

module EacDocker
  module Debug
    class << self
      ENABLE_ENVVAR = 'EAC_DOCKER_DEBUG'

      def enabled?
        ::EacRubyUtils::Boolean.parse(ENV.fetch(ENABLE_ENVVAR, nil))
      end
    end
  end
end
