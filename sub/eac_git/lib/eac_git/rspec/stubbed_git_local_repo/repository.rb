# frozen_string_literal: true

require 'eac_git/local'
require 'eac_git/rspec/stubbed_git_local_repo/file'
require 'eac_ruby_utils/core_ext'
require 'securerandom'

module EacGit
  module Rspec
    module StubbedGitLocalRepo
      class Repository < ::EacGit::Local
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
    end
  end
end
