# frozen_string_literal: true

module EacGit
  class Local
    class Remote
      class Push
        acts_as_immutable
        immutable_accessor :force, type: :boolean
        immutable_accessor :refspec, type: :array

        common_constructor :remote
        delegate :local, to: :remote

        # @return [Array<Object>]
        def immutable_constructor_args
          [remote]
        end

        # @return [void]
        def perform
          local.command(*git_command_args).system!
        end

        # @return [Enumerable<String>]
        def git_command_args
          r = ['push', remote.name]
          r << '--force' if force?
          r + refspecs
        end
      end
    end
  end
end
