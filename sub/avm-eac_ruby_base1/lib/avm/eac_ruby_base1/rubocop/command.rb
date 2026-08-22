# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Rubocop
      class Command
        acts_as_immutable
        immutable_accessor :autocorrect_safe, :autocorrect_unsafe, :ignore_parent_exclusion,
                           :old_options, type: :boolean
        immutable_accessor :file, type: :array
        immutable_accessor :config, :format, :gemfile, type: :common

        # @return [String]
        def autocorrect_safe_option
          old_options? ? '--auto-correct' : '--autocorrect'
        end

        # @return [String]
        def autocorrect_unsafe_option
          old_options? ? '--auto-correct-all' : '--autocorrect-all'
        end

        # @return [Array<String>]
        def autocorrect_to_args
          if autocorrect_unsafe?
            [autocorrect_unsafe_option]
          elsif autocorrect_safe?
            [autocorrect_safe_option]
          else
            []
          end
        end

        # @return [Array<String>]
        def build_args
          %w[prefix config ignore_parent_exclusion autocorrect format files].inject([]) do |a, e|
            a + send("#{e}_to_args")
          end
        end

        # @return [Array<String>]
        def bundle_command_args
          %w[exec rubocop] + rubocop_command_args
        end

        # @return [Array<String>]
        def config_to_args
          config.if_present([]) { |v| ['--config', v] }
        end

        # @return [Array<String>]
        def files_to_args
          files
        end

        # @return [Array<String>]
        def format_to_args
          format.if_present([]) { |v| ['--format', v] }
        end

        # @return [String]
        def ignore_parent_exclusion_option
          '--ignore-parent-exclusion'
        end

        # @return [Array<String>]
        def ignore_parent_exclusion_to_args
          ignore_parent_exclusion? ? [ignore_parent_exclusion_option] : []
        end

        # @return [Array<String>]
        def prefix_to_args
          (gemfile.present? ? %w[bundle exec] : []) + ['rubocop']
        end

        require_sub __FILE__, require_mode: :kernel
      end
    end
  end
end
