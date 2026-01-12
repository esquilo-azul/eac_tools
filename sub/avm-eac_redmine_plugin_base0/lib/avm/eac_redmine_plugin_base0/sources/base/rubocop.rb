# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        module Rubocop
          RUBOCOP_GEM_NAME = 'rubocop'
          RUBOCOP_TEST_NAME = 'rubocop'

          # @return [EacRubyUtils::Envs::Command]
          def rubocop_test_command
            bundle('exec', 'rubocop', '--ignore-parent-exclusion')
              .envvar('RAILS_ENV', 'test')
              .chdir_root
          end

          # @return [Boolean]
          def rubocop_test_command?
            gemfile_path.exist? && gemfile_lock_gem_version(RUBOCOP_GEM_NAME).present?
          end
        end
      end
    end
  end
end
