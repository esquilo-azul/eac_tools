# frozen_string_literal: true

require 'eac_git/local'
require 'eac_ruby_utils/envs'
require 'securerandom'
require 'tmpdir'

module EacGit
  module Rspec
    module StubbedGitLocalRepo
      def stubbed_git_local_repo(bare = false) # rubocop:disable Style/OptionalBooleanParameter
        path = ::Dir.mktmpdir
        ::EacRubyUtils::Envs.local.command(stubbed_git_local_repo_args(path, bare)).execute!
        repo = StubbedGitRepository.new(path)
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

      class StubbedGitRepository < ::EacGit::Local
        def file(*subpath)
          ::EacGit::Rspec::StubbedGitLocalRepo::File.new(self, subpath)
        end

        # @return [EacGit::Local::Commit
        def random_commit
          content = ::SecureRandom.hex
          file = "#{content}.txt"
          file(file).write(content)
          command('add', file).execute!
          command('commit', '-m', "Random commit: #{file}.").execute!
          head
        end
      end

      require_sub __FILE__
    end
  end
end
