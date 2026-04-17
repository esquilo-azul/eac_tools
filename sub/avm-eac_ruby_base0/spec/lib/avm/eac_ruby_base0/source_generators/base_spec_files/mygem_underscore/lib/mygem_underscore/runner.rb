# frozen_string_literal: true

require 'eac_ruby_base0/runner'
require 'mygem_underscore/application'

module MygemUnderscore
  class Runner
    include ::EacRubyBase0::Runner

    runner_definition do
      desc 'Tools for mygem_underscore.'
    end

    # @return [EacRubyBase0::Application]
    def application
      ::MygemUnderscore.application
    end

    require_sub __FILE__
  end
end
