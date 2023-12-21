# frozen_string_literal: true

require 'fileutils'

module EacGit
  module Rspec
    module StubbedGitLocalRepo
      class File
        attr_reader :git, :subpath

        def initialize(git, subpath)
          @git = git
          @subpath = subpath
        end

        def path
          git.root_path.join(*subpath)
        end

        def touch
          ::FileUtils.touch(path.to_path)
        end

        def delete
          path.unlink
        end

        delegate :write, to: :path
      end
    end
  end
end
