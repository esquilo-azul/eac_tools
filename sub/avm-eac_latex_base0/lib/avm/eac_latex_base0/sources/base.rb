# frozen_string_literal: true

require 'avm/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacLatexBase0
    module Sources
      class Base < ::Avm::Sources::Base
        def chapters
          chapters_file.read.split("\n").map(&:strip).reject { |c| c == '' }
        end

        def chapters_file
          root.join('chapters')
        end

        def main_file
          path.join('main.tex')
        end

        def name
          root.basename.to_s
        end

        def default_output_dir
          root.join('dist')
        end

        def default_output_file
          root.join("#{name}.pdf")
        end

        def root
          path
        end

        def valid?
          main_file.file?
        end
      end
    end
  end
end
