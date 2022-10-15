# frozen_string_literal: true

require 'eac_git/remote_like'
require 'eac_ruby_utils/core_ext'

module EacGit
  class Local
    class Remote
      NO_SUCH_REMOTE_CODE = 128

      enable_simple_cache
      include ::EacGit::RemoteLike

      common_constructor :local, :name

      def exist?
        url
      end

      # @return [EacRubyUtils::Envs::Command
      def git_command(*args)
        local.command(*args)
      end

      # @return [String]
      def remote_reference
        name
      end

      # @return [String, nil]
      def url
        local.command('remote', 'get-url', name)
          .execute!(exit_outputs: { NO_SUCH_REMOTE_CODE => nil })
          .if_present(nil, &:strip)
      end
    end
  end
end
