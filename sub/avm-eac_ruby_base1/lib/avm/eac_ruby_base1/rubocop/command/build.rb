# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Rubocop
      class Command
        class Build
          acts_as_instance_method
          common_constructor :owner

          # @return [EacRubyUtils::Ruby::Command]
          def result
            %i[execution_callback gemfile]
              .inject(::EacRubyUtils::Envs.local.command(*owner.build_args)) do |a, e|
                send("apply_for_#{e}", a)
              end
          end

          protected

          def apply_for_execution_callback(command)
            command.singleton_class.set_callback :any_execution, :around do |_record, block|
              ::EacRubyUtils::Ruby.on_clean_environment do
                block.call
              end
            end
            command
          end

          def apply_for_gemfile(command)
            owner.gemfile.if_present(command) do |v|
              command.envvar(
                ::Avm::EacRubyBase1::Sources::Base::BundleCommand::GEMFILE_PATH_ENVVAR, v
              )
            end
          end
        end
      end
    end
  end
end
