# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRubyGemSupport
  class SourceTargetFixtures
    class SourceTargetFile
      common_constructor :owner, :basename

      def source
        owner.source_file(basename)
      end

      def target
        owner.target_file(basename)
      end
    end
  end
end
