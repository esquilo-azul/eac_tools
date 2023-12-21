# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacGit
  module Rspec
    module StubbedGitLocalRepo
      class FsObject
        # @!attribute [r] git
        #   @param git [EacGit::Rspec::StubbedGitLocalRepo::Repository]

        # @!attribute [r] subpath
        #   @param git [Array<String>]

        # @!method initialize(git, subpath)
        #   @param git [EacGit::Rspec::StubbedGitLocalRepo::Repository]
        #   @param subpath [Array<String>
        common_constructor :git, :subpath

        def path
          git.root_path.join(*subpath)
        end
      end
    end
  end
end
