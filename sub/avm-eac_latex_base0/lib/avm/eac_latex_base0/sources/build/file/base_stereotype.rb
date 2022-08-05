# frozen_string_literal: true

module Avm
  module EacLatexBase0
    module Sources
      class Build
        class File
          module BaseStereotype
            private

            def target_subpath
              subpath
            end

            def copy(target_path)
              FileUtils.copy_file(source_path, target_path)
            end
          end
        end
      end
    end
  end
end
