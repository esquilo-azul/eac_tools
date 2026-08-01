# frozen_string_literal: true

module EacRubyBase0
  module Runner
    module Prepend
      ERROR_EXIT_CODE = 113

      def run
        on_rescue_errors do
          if parsed.version?
            show_version
          else
            run_with_subcommand
          end
        end
      end

      def run_run
        on_context { super }
      end

      protected

      # @return [void]
      def on_rescue_errors
        yield
      rescue Exception => e # rubocop:disable Lint/RescueException
        ::EacRubyBase0::ErrorPresenter.new(e).show
        exit ERROR_EXIT_CODE
      end
    end
  end
end
