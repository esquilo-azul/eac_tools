# frozen_string_literal: true

module EacGit
  module Executables
    class << self
      enable_memoized

      def env
        ::EacRubyUtils::Envs.local
      end

      memoize def git
        r = env.executable('git', '--version')
        r.extend(::EacGit::Executables::GitCommandExtensions)
        r
      end

      memoize def tar
        env.executable('tar', '--version')
      end
    end
  end
end
