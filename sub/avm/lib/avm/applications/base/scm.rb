# frozen_string_literal: true

require 'avm/registry'
require 'eac_ruby_utils/core_ext'

module Avm
  module Applications
    class Base
      module Scm
        common_concern do
          uri_components_entries_values 'scm', %w[repos_path type]
        end

        # @return [Avm::ApplicationScms::Base]
        def scm
          @scm ||= ::Avm::Registry.application_scms.detect(self)
        end

        # @param value [String]
        # @return [String]
        def scm_repos_path_inherited_value_proc(value)
          value.to_pathname.join(id).to_path
        end
      end
    end
  end
end
