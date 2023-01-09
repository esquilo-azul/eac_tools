# frozen_string_literal: true

require 'avm/file_formats/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGenericBase0
    class FileFormats
      class Base < ::Avm::FileFormats::Base
        require_sub __FILE__, include_modules: true

        VALID_BASENAMES = %w[*.asm *.bat *.coffee *.java *.js *.rb *.s *.sql *.tex *.url *.yml
                             *.yaml].freeze

        VALID_TYPES = %w[plain x-shellscript].freeze

        def internal_apply(files)
          files.each { |file| file_apply(file) }
        end

        def file_apply(file)
          file.write(string_apply(file.read))
        end

        def string_apply(string)
          b = ''
          string.each_line do |line|
            b += "#{line.rstrip}\n"
          end
          "#{b.strip}\n".gsub(/\t/, '  ')
        end
      end
    end
  end
end
