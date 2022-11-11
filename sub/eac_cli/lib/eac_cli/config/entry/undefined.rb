# frozen_string_literal: true

require 'eac_cli/speaker/input_requested'
require 'eac_config/entry/not_found_error'
require 'eac_config/node_entry'
require 'eac_ruby_utils/core_ext'

module EacCli
  class Config < ::SimpleDelegator
    class Entry < ::EacConfig::NodeEntry
      module Undefined
        private

        def undefined_value
          loop do
            entry_value = undefined_value_no_loop
            next unless options[:validator].if_present(true) { |v| v.call(entry_value) }

            return entry_value
          end
        end

        def undefined_value_no_loop
          input("Value for entry \"#{path}\"", options.request_input_options)
        rescue ::EacCli::Speaker::InputRequested
          raise ::EacConfig::Entry::NotFoundError, self
        end
      end
    end
  end
end
