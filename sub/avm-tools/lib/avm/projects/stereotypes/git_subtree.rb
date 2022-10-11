# frozen_string_literal: true

require 'avm/launcher/stereotype'
require 'avm/projects/stereotypes/git'
require 'eac_ruby_utils/core_ext'

module Avm
  module Projects
    module Stereotypes
      class GitSubtree
        require_sub __FILE__
        include Avm::Launcher::Stereotype

        class << self
          def match?(path)
            return false if other_git_stereotype?(path)
            return false unless other_nogit_stereotype?(path)

            parent = parent_git(path.parent_path)
            return false unless parent

            ::Git.open(parent.real).remote(path.real.basename).url ? true : false
          end

          def color
            :green
          end

          def parent_git(parent_path)
            return nil unless parent_path

            if ::Avm::Projects::Stereotypes::Git.match?(parent_path)
              parent_path
            else
              parent_git(parent_path.parent_path)
            end
          end

          def other_git_stereotype?(path)
            ::Avm::Projects::Stereotypes::Git.match?(path) ||
              ::Avm::Projects::Stereotypes::GitSubrepo.match?(path)
          end

          def other_nogit_stereotype?(path)
            Avm::Launcher::Stereotype.nogit_stereotypes.any? { |s| s.match?(path) }
          end
        end
      end
    end
  end
end
