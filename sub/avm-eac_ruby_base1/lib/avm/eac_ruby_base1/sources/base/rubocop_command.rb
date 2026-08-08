# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Sources
      class Base < ::Avm::EacGenericBase0::Sources::Base
        class RubocopCommand
          acts_as_immutable
          immutable_accessor :ignore_parent_exclusion, :autocorrect, :autocorrect_all,
                             type: :boolean
          immutable_accessor :file, type: :array
          common_constructor :source
          delegate :execute, :execute!, :system, :system!, to: :bundle_command

          # @return [Enumerable]
          def immutable_constructor_args
            [source]
          end

          # @return [Gemspec::Version]
          def version
            @version ||= ::Gem::Version.new(
              rubocop_command.extra_arg('--version').build.execute!
            )
          end

          private

          # @return [EacRubyUtils::Ruby::Command]
          def bundle_command # rubocop:disable Metrics/AbcSize
            r = rubocop_command
                  .autocorrect_safe(autocorrect?)
                  .autocorrect_unsafe(autocorrect_all?)
                  .files(files)
                  .gemfile(source.gemfile_path)
                  .ignore_parent_exclusion(ignore_parent_exclusion)
            r = r.config(source.rubocop_config_path) if source.rubocop_config_path.file?
            r.build
          end

          # @return [Avm::EacRubyBase1::Rubocop::Command]
          def rubocop_command
            ::Avm::EacRubyBase1::Rubocop::Command.new.gemfile(source.gemfile_path)
          end
        end
      end
    end
  end
end
