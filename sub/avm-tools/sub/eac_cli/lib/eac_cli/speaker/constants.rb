# frozen_string_literal: true

require 'eac_ruby_utils/by_reference'

module EacCli
  class Speaker
    module Constants
      STDERR = ::EacRubyUtils::ByReference.new { $stderr }
      STDIN = ::EacRubyUtils::ByReference.new { $stdin }
      STDOUT = ::EacRubyUtils::ByReference.new { $stdout }
    end
  end
end
