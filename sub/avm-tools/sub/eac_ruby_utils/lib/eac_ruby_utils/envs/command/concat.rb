# frozen_string_literal: true

require 'eac_ruby_utils/struct'

module EacRubyUtils
  module Envs
    class Command
      module Concat
        def concat(operator, other_command)
          duplicate_by_extra_options(concat: ::EacRubyUtils::Struct.new(
            operator: operator, command: other_command
          ))
        end

        def or(other_command)
          concat('||', other_command)
        end

        def pipe(other_command)
          concat('|', other_command)
        end

        private

        def append_concat(command)
          extra_options[:concat].if_present(command) do |v|
            "#{command} #{v.operator} #{v.command.command}"
          end
        end
      end
    end
  end
end
