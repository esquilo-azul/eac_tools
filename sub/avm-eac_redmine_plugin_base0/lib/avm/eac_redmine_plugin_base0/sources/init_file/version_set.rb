# frozen_string_literal: true

module Avm
  module EacRedminePluginBase0
    module Sources
      class InitFile
        class VersionSet
          acts_as_instance_method
          common_constructor :init_file, :new_value

          # @return [String]
          def result
            init_file.path.write(new_value_content(new_value))
          end

          protected

          # @param new_value [String]
          # @return [String]
          def new_value_content(new_value)
            path.read.each_line
              .map { |line| new_value_line(line, new_value) }
              .join
          end

          # @param line [String]
          # @param new_value [String]
          # @return [String]
          def new_value_line(line, new_value)
            m = Avm::EacRedminePluginBase0::Sources::InitFile::VERSION_LINE_PATTERN.match(line)
            return line unless m

            "#{m[1]}version '#{new_value}'"
          end
        end
      end
    end
  end
end
