# frozen_string_literal: true

module Dashed
  module Mygem
    class Runner
      include ::EacRubyBase0::Runner

      runner_definition do
        desc 'Tools for dashed-mygem.'
      end

      delegate :application, to: :'::Dashed::Mygem::Self'

      require_sub __FILE__
    end
  end
end
