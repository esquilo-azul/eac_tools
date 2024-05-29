# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacRubyBase0
    module Rspec
      module SourceGenerator
        APPLICATION_STEREOTYPE = 'EacRubyBase0'
        DEFAULT_VERSIONS = {
          'eac_ruby_base0' => '0.9.0',
          'eac_ruby_gem_support' => '0.10.0',
          'eac_ruby_utils' => '0.122.0'
        }.freeze

        # @return [Avm::EacRubyBase0::Sources::Base]
        def avm_eac_ruby_base0_source(options = {})
          avm_source(
            APPLICATION_STEREOTYPE,
            avm_eac_ruby_base0_source_default_options.merge(options)
          )
        end

        # @return [Hash]
        def avm_eac_ruby_base0_source_default_options
          DEFAULT_VERSIONS.transform_keys do |gem_name|
            "#{gem_name}_version".dasherize
          end
        end
      end
    end
  end
end
