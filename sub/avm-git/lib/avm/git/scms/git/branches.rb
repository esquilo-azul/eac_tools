# frozen_string_literal: true

require 'avm/scms/commit'
require 'eac_ruby_utils/core_ext'

module Avm
  module Git
    module Scms
      class Git < ::Avm::Scms::Base
        module Branches
          # @return [Avm::Git::Scms::Git::Branch]
          def head_branch
            ::Avm::Git::Scms::Git::Branch.new(self,
                                              git_repo.current_branch)
          end
        end
      end
    end
  end
end
