# frozen_string_literal: true

require 'avm/eac_webapp_base0/runner'
require 'avm/eac_asciidoctor_base0'

module Avm
  module Tools
    class Runner
      class EacAsciidoctorBase0 < ::Avm::EacWebappBase0::Runner
        require_sub __FILE__
      end
    end
  end
end
