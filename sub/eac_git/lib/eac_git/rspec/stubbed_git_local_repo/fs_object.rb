# frozen_string_literal: true

module EacGit
  module Rspec
    module StubbedGitLocalRepo
      class FsObject
        attr_reader :git, :subpath

        def initialize(git, subpath)
          @git = git
          @subpath = subpath
        end

        def path
          git.root_path.join(*subpath)
        end
      end
    end
  end
end
