# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Scms
    class Base
      module Commits
        # @return [Avm::Scms::Commit,NilClass]
        def commit_if_change(_message = nil)
          raise_abstract_method __method__
        end

        # @return [Avm::Scms::Commit]
        def head_commit
          raise_abstract_method __method__
        end
      end
    end
  end
end
