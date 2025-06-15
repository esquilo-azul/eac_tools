# frozen_string_literal: true

require 'eac_git/executables'
require 'eac_git/remote_like'
require 'eac_ruby_utils'

module EacGit
  # A Git remote repository referenced by URI.
  class Remote
    include ::EacGit::RemoteLike

    common_constructor :uri

    # @return [EacRubyUtils::Envs::Command
    def git_command(...)
      ::EacGit::Executables.git.command(...)
    end

    # @return [String]
    def remote_reference
      uri
    end
  end
end
