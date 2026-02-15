# frozen_string_literal: true

module EacTools
  class Runner < ::Avm::Tools::Runner
    runner_definition do
      desc 'Tools for E.A.C..'
    end

    delegate :application, to: :'EacTools::Self'
  end
end
