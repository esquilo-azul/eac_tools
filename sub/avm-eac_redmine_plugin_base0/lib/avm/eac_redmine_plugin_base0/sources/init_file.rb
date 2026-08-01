# frozen_string_literal: true

module Avm
  module EacRedminePluginBase0
    module Sources
      class InitFile
        common_constructor :path

        VERSION_LINE_PATTERN = /\A(\s*)version\s*['"]([^'"]+)['"](\s*)\z/

        def version=(new_value)
          path.write(new_value_content(new_value))
        end

        private

        def new_value_content(new_value)
          path.read.each_line
            .map { |line| new_value_line(line, new_value) }
            .join
        end

        def new_value_line(line, new_value)
          m = VERSION_LINE_PATTERN.match(line)
          return line unless m

          "#{m[1]}version '#{new_value}'"
        end

        require_sub __FILE__, require_mode: :kernel
      end
    end
  end
end
