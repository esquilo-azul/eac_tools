# frozen_string_literal: true

module EacRubyGemSupport
  module Rspec
    class SourceTargetFixturesController
      enable_simple_cache
      common_constructor :spec_paths_controller
      delegate :example, to: :spec_paths_controller

      def fixtures_dir
        if example.respond_to?(:fixtures_dir)
          example.fixtures_dir
        else
          spec_paths_controller.fixtures_directory
        end
      end

      def write_target_fixtures?
        ENV['WRITE_TARGET_FIXTURES'].to_bool
      end

      private

      def source_target_fixtures_uncached
        ::EacRubyGemSupport::SourceTargetFixtures.new(fixtures_dir)
      end
    end
  end
end
