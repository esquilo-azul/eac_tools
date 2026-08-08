# frozen_string_literal: true

module Avm
  module EacRedminePluginBase0
    module Sources
      class InitFile
        class PluginId
          acts_as_instance_method
          common_constructor :init_file

          PLUGIN_ID_PARSER = /Redmine::Plugin.register\s+:([^\s]+)\s/.to_parser do |m|
            m[1].to_sym
          end

          # @return [Symbol]
          def result
            init_file.find_on_line { |line| PLUGIN_ID_PARSER.parse(line) }
          end
        end
      end
    end
  end
end
