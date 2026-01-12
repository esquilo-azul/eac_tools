# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs'

module Avm
  module EacWebappBase0
    module Executables
      class << self
        enable_simple_cache

        def env
          ::EacRubyUtils::Envs.local
        end

        private

        %w[cssbeautify-cli js-beautify tidy].each do |program|
          define_method("#{program.underscore}_uncached") do
            env.executable(program, '--version')
          end
        end
      end
    end
  end
end
