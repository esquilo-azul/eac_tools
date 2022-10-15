# frozen_string_literal: true

require 'eac_git/executables'
require 'eac_git/remote_like'
require 'eac_ruby_utils/core_ext'

module EacGit
  # A Git remote repository referenced by URI.
  class Remote
    require_sub __FILE__
    include ::EacGit::RemoteLike

    common_constructor :uri

    # @return [EacRubyUtils::Envs::Command
    def git_command(*args, &block)
      ::EacGit::Executables.git.command(*args, &block)
    end

    # @return [String]
    def remote_reference
      uri
    end
  end
end
