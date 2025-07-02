# frozen_string_literal: true

require 'tmpdir'

module EacGit
  module Rspec
    module StubbedGitLocalRepo
      def stubbed_git_local_repo(bare = false) # rubocop:disable Style/OptionalBooleanParameter
        path = ::Dir.mktmpdir
        ::EacRubyUtils::Envs.local.command(stubbed_git_local_repo_args(path, bare)).execute!
        repo = ::EacGit::Rspec::StubbedGitLocalRepo::Repository.new(path)
        repo.command('config', 'user.email', 'theuser@example.net').execute!
        repo.command('config', 'user.name', 'The User').execute!
        repo
      end

      private

      def stubbed_git_local_repo_args(path, bare)
        r = %w[git init]
        r << '--bare' if bare
        r + [path]
      end

      require_sub __FILE__
    end
  end
end
