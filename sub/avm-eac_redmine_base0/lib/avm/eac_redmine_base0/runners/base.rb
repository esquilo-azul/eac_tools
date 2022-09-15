# frozen_string_literal: true

require 'avm/eac_redmine_base0/instances/base'
require 'avm/eac_redmine_base0/instances/deploy'
require 'avm/eac_redmine_base0/instances/apache_host'
require 'avm/eac_rails_base1/runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedmineBase0
    module Runners
      class Base < ::Avm::EacRailsBase1::Runner
        require_sub __FILE__

        STEREOTYPE_NAME = 'EacRedmineBase0'

        class << self
          def stereotype_name
            STEREOTYPE_NAME
          end
        end
      end
    end
  end
end
