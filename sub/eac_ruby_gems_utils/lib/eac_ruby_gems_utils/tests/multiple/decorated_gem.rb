# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRubyGemsUtils
  module Tests
    class Multiple
      class DecoratedGem < ::SimpleDelegator
        enable_speaker

        def prepare
          return unless gemfile_path.exist?

          log('running "bundle install"...')
          return if bundle('install').execute.fetch(:exit_code).zero?

          unless can_remove_gemfile_lock?
            raise '"bundle install" failed and the Gemfile.lock is part of gem' \
                '(Should be changed by developer)'
          end

          prepare_with_removable_gemfile_lock
        end

        def tests
          [::EacRubyGemsUtils::Tests::Minitest.new(__getobj__),
           ::EacRubyGemsUtils::Tests::Rspec.new(__getobj__)]
        end

        private

        def log(message)
          infov self, message
        end

        def prepare_with_removable_gemfile_lock
          log('"bundle install" failed, removing Gemfile.lock and trying again...')
          gemfile_lock_path.unlink if gemfile_lock_path.exist?
          bundle('install').execute!
        end

        def can_remove_gemfile_lock?
          !files.include?(gemfile_lock_path.relative_path_from(root))
        end
      end
    end
  end
end
