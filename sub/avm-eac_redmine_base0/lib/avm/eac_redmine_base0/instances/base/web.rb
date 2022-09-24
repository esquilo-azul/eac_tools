# frozen_string_literal: true

require 'avm/eac_rails_base1/instances/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedmineBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        module Web
          def web_authority
            web_hostname.if_present do |h|
              h.to_s + web_port_optional.if_present('') { |p| ":#{p}" }
            end
          end
        end
      end
    end
  end
end
