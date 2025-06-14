# frozen_string_literal: true

require 'eac_ruby_utils'
require 'eac_templates/errors/not_found'

module EacTemplates
  module Sources
    module FsObject
      PATH_FOR_SEARCH_PREFIX = ::Pathname.new('')

      common_concern do
        enable_abstract_methods
        enable_simple_cache
      end

      # @return [Boolean]
      def found?
        real_paths.any?
      end

      # @return [Pathname]
      def path
        real_paths.first
      end

      # @return [Pathname]
      def path_for_search_prefix
        PATH_FOR_SEARCH_PREFIX
      end

      # @return [String]
      def to_s
        "#{self.class.name}[#{path_for_search}]"
      end

      protected

      # @return [Array<Pathname>]
      def real_paths_uncached
        source_set.included_paths.lazy.map { |source_single| source_single_search(source_single) }
          .reject(&:nil?) # rubocop:disable Style/CollectionCompact
      end

      # @param path [Pathname]
      # @return [Boolean]
      def select_path?(path)
        !path.nil? && path.send("#{type}?")
      end

      # @param source_single [EacTemplates::Sources::Single]
      # @return [Pathname, nil]
      def source_single_search(source_single)
        r = source_single.search(path_for_search)
        select_path?(r) ? r : nil
      end
    end
  end
end
