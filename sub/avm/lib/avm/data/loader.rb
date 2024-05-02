# frozen_string_literal: true

require 'avm/data/performer'
require 'avm/data/rotate'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/fs/temp'

module Avm
  module Data
    class Loader < ::Avm::Data::Performer
      immutable_accessor :source_path

      # @return [String, nil]
      def cannot_perform_reason
        return 'Source path not set' if source_path.blank?
        return "\"#{source_path}\" is not a file" unless source_path.file?

        nil
      end

      protected

      def internal_perform
        data_owner.load(source_path, *include_excludes_arguments)
      end
    end
  end
end
