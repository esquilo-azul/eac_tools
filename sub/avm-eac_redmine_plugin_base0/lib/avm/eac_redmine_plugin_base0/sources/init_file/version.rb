# frozen_string_literal: true

module Avm
  module EacRedminePluginBase0
    module Sources
      class InitFile
        class Version
          acts_as_instance_method
          common_constructor :init_file

          # @return [Avm::VersionNumber, nil] Version found in line, nil otherwise.
          def result
            init_file.path.read.each_line.lazy.map { |line| line_value(line) }.find { |v| v }
          end

          protected

          # @return [Avm::VersionNumber, nil] Version found in line, nil otherwise.
          def line_value(line)
            Avm::EacRedminePluginBase0::Sources::InitFile::VERSION_LINE_PATTERN
              .if_match(line.rstrip, false) { |m| ::Avm::VersionNumber.new(m[2]) }
          end
        end
      end
    end
  end
end
