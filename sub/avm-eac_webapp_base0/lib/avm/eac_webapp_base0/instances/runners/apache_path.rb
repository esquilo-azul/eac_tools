# frozen_string_literal: true

require 'eac_cli/core_ext'

module Avm
  module EacWebappBase0
    module Instances
      module Runners
        class ApachePath
          runner_with :help do
            desc 'Configure Apache path configuration for instance.'
          end

          def run
            if result.error?
              fatal_error result.to_s
            else
              infov 'Result', result.label
            end
          end

          private

          def apache_path_uncached
            stereotype_apache_path_class.new(runner_context.call(:instance))
          end

          def result_uncached
            apache_path.run
          end

          def stereotype_apache_path_class
            "#{runner_context.call(:instance).class.name.deconstantize}::ApachePath".constantize
          end
        end
      end
    end
  end
end
