# frozen_string_literal: true

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
