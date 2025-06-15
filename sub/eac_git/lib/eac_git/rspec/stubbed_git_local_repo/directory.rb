# frozen_string_literal: true

require 'fileutils'

module EacGit
  module Rspec
    module StubbedGitLocalRepo
      class Directory < ::EacGit::Rspec::StubbedGitLocalRepo::FsObject
        # @return [self]
        def create
          ::FileUtils.mkdir_p(path)
          self
        end

        # @return [self]
        def delete
          ::FileUtils.rm_rf(path)
          self
        end

        # @param subpath [Array<String>]
        # @return [EacGit::Rspec::StubbedGitLocalRepo::Directory]
        def directory(*subpath)
          git.directory(*self.subpath, *subpath)
        end

        # @param subpath [Array<String>]
        # @return [EacGit::Rspec::StubbedGitLocalRepo::File]
        def file(*subpath)
          git.file(*self.subpath, *subpath)
        end
      end
    end
  end
end
