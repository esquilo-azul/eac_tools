# frozen_string_literal: true

require 'avm/file_formats/base'
require 'eac_fs/file_info'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGenericBase0
    class FileFormats
      class Base < ::Avm::FileFormats::Base
        class Match
          DEFAULT_TYPE = 'text'

          common_constructor :file_format, :file

          # @return [Boolean]
          def result
            result_by_filename? || result_by_type?
          end

          # @return [Array<String>]
          def valid_basenames
            constant_or_array('VALID_BASENAMES')
          end

          # @return [Array<String>]
          def valid_types
            constant_or_array('VALID_TYPES').map do |mime_type|
              mime_type_sanitize(mime_type)
            end
          end

          protected

          # @return [String]
          def mime_type_sanitize(mime_type)
            if mime_type.split('/').count > 1
              mime_type
            else
              "#{DEFAULT_TYPE}/#{mime_type}"
            end
          end

          private

          # @return [Array<String>]
          def constant_or_array(name)
            return [] unless file_format.class.const_defined?(name)

            file_format.class.const_get(name)
          end

          # @return [Boolean]
          def result_by_filename?
            valid_basenames.any? do |valid_basename|
              file.basename.fnmatch?(valid_basename)
            end
          end

          # @return [Boolean]
          def result_by_type?
            info = ::EacFs::FileInfo.new(file)
            valid_types.include?(info.content_type.mime_type)
          end
        end
      end
    end
  end
end
