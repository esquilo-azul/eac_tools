# frozen_string_literal: true

module MygemUnderscore
  class Runner
    include ::EacRubyBase0::Runner

    runner_definition do
      desc 'Tools for mygem_underscore.'
    end

    delegate :application, to: :'::MygemUnderscore::Self'

    require_sub __FILE__
  end
end
