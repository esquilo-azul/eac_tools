# frozen_string_literal: true

module Avm
  module Git
    module Scms
      class GitSubBase < ::Avm::Scms::Base
        class Interval < ::Avm::Scms::Interval
          # @return [Array<Avm::Git::Scms::GitSubBase::Commit>]
          def commits
            parent_interval.commits.map do |parent_commit|
              Avm::Git::Scms::GitSubBase::Commit.new(scm, parent_commit)
            end
          end

          # @return [Avm::Git::Scms::Git::Interval]
          def parent_interval
            scm.parent_scm.interval(from, to)
          end
        end
      end
    end
  end
end
