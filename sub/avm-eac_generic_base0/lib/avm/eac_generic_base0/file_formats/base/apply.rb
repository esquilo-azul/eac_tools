# frozen_string_literal: true

require 'avm/file_formats/base'
require 'avm/file_formats/file_result'
require 'avm/file_formats/utf8_assert'

module Avm
  module EacGenericBase0
    class FileFormats
      class Base < ::Avm::FileFormats::Base
        class Apply
          enable_method_class
          common_constructor :file_format, :files

          # @return [Enumerable<Avm::FileFormats::FileResult>]
          def result
            old_content = files.index_with { |f| File.read(f) }
            ::Avm::FileFormats::Utf8Assert.assert_files(files) { file_format.internal_apply(files) }
            files.map { |f| file_result(f, old_content[f]) }
          end

          # @param path [Pathname]
          # @param old_content [String]
          # @return [Avm::FileFormats::FileResult]
          def file_result(file, old_content)
            ::Avm::FileFormats::FileResult.new(file, file_format.class,
                                               old_content != File.read(file))
          end
        end
      end
    end
  end
end
