# frozen_string_literal: true

module Avm
  module EacLatexBase0
    module Sources
      class Build
        class File
          module ChapterIndex
            class << self
              def match?(subpath)
                ::File.basename(subpath) == 'index.tex'
              end
            end

            private

            def target_subpath
              ::Avm::EacLatexBase0::Sources::Build.chapter_filename( # rubocop:disable Style/StringConcatenation
                File.basename(File.dirname(subpath))
              ) + '.tex'
            end
          end
        end
      end
    end
  end
end
