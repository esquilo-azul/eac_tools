# frozen_string_literal: true

require 'eac_ruby_base0/runner'
require 'dashed/mygem/application'

module Dashed
  module Mygem
    class Runner
      include ::EacRubyBase0::Runner

      runner_definition do
        desc 'Tools for dashed-mygem.'
      end

      # @return [EacRubyBase0::Application]
      def application
        ::Dashed::Mygem.application
      end

      require_sub __FILE__
    end
  end
end
