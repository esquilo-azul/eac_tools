# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs'

module Avm
  module EacPythonBase0
    module Executables
      class << self
        enable_simple_cache

        private

        %w[latex].each do |program|
          define_method(program.underscore + '_uncached') do
            ::EacRubyUtils::Envs.local.executable(program, '--version')
          end
        end
      end
    end
  end
end
