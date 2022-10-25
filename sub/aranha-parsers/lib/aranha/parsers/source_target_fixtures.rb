# frozen_string_literal: true

require 'active_support/core_ext/object'
require 'active_support/core_ext/string'

module Aranha
  module Parsers
    # Lists pairs of source/target files in a directory.
    class SourceTargetFixtures
      class << self
        def source_target_basename(file)
          m = /^(.+)\.(?:source|target)(?:\..+)?$/.match(File.basename(file))
          m ? m[1] : nil
        end
      end

      attr_reader :fixtures_directory

      def initialize(fixtures_directory)
        @fixtures_directory = fixtures_directory
      end

      def source_target_files
        sources_targets_basenames.map do |basename|
          OpenStruct.new(basename: basename, source: source_file(basename),
                         target: target_file(basename))
        end
      end

      def source_files
        r = []
        source_target_files.each do |st|
          r << st.source if st.source
        end
        r
      end

      def target_files
        r = []
        source_target_files.each do |st|
          r << st.target if st.target
        end
        r
      end

      def target_file(basename)
        fixture_file(basename, 'target')
      end

      def source_file(basename)
        fixture_file(basename, 'source')
      end

      private

      def fixture_file(basename, suffix)
        prefix = "#{basename}.#{suffix}"
        Dir.foreach(fixtures_directory) do |item|
          next if %w[. ..].include?(item)
          return File.expand_path(item, fixtures_directory) if item.starts_with?(prefix)
        end
        nil
      end

      def sources_targets_basenames
        basenames = Set.new
        Dir.foreach(fixtures_directory) do |item|
          next if %w[. ..].include?(item)

          b = self.class.source_target_basename(item)
          basenames << b if b.present?
        end
        basenames
      end
    end
  end
end
