# frozen_string_literal: true

require 'eac_cli/runner'
require 'eac_ruby_utils/core_ext'

module EacRubyBase0
  module RunnerWith
    module Confirmation
      DEFAULT_CONFIRM_QUESTION_TEXT = 'Confirm?'

      common_concern do
        include ::EacCli::Runner
        enable_settings_provider
        enable_simple_cache
        runner_definition do
          bool_opt '--no', 'Deny confirmation without question.'
          bool_opt '--yes', 'Accept confirmation without question.'
        end
      end

      def confirm?(message = nil)
        return false if parsed.no?
        return true if parsed.yes?

        input(
          message || setting_value(:confirm_question_text, default: DEFAULT_CONFIRM_QUESTION_TEXT),
          bool: true
        )
      end

      def run_confirm(message = nil)
        yield if confirm?(message)
      end

      private

      def cached_confirm_uncached?(message = nil)
        confirm?(message)
      end
    end
  end
end
