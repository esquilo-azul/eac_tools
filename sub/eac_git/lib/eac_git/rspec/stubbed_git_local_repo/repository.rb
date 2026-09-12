# frozen_string_literal: true

require 'securerandom'

module EacGit
  module Rspec
    module StubbedGitLocalRepo
      class Repository < ::EacGit::Local
        # @return [EacGit::Rspec::StubbedGitLocalRepo::Directory]
        def directory(*subpath)
          ::EacGit::Rspec::StubbedGitLocalRepo::Directory.new(self, subpath)
        end

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
