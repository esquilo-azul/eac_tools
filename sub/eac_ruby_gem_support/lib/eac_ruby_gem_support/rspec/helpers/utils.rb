# frozen_string_literal: true

require 'fileutils'
require 'tmpdir'
require 'tempfile'

module EacRubyGemSupport
  module Rspec
    module Helpers
      module Utils
        # @return [StandardError, nil] If block raises an error, return this error. If not, return
        #   +nil+.
        def capture_error
          yield
          nil
        rescue ::StandardError => e
          e
        end
      end
    end
  end
end
