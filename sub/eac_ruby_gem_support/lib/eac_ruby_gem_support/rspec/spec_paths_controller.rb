# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRubyGemSupport
  module Rspec
    class SpecPathsController
      # @!attribute [r] spec_file
      #   @return [Pathname]

      # @!method initialize(example, spec_file)
      #   @param example [RSpec::Core::ExampleGroup]
      #   @param spec_file [Pathname]
      common_constructor :example, :spec_file do
        self.spec_file = spec_file.to_pathname
      end

      # @return [Pathname]
      def fixtures_directory
        spec_directory.join(spec_file.basename('.*')).basename_sub { |b| "#{b}_files" }
      end

      # @return [Pathname]
      def spec_directory
        spec_file.parent
      end
    end
  end
end
