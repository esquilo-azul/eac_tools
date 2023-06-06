# frozen_string_literal: true

require 'avm/instances/process'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase1
    module Instances
      module Processes
        class Daemon < ::Avm::Instances::Process
          acts_as_abstract :command_name, :gem_name

          # @return [Boolean]
          def available?
            instance.the_gem.gemfile_lock_gem_version(gem_name).present?
          end

          def disable
            daemon_command(:stop).system!
          end

          def enable
            daemon_command(:start).system!
          end

          def enabled?
            daemon_command(:status).execute.fetch(:exit_code).zero?
          end

          private

          def daemon_command(action)
            instance.bundle('exec', command_name, action)
          end
        end
      end
    end
  end
end
