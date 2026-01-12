# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacWebappBase0
    module Instances
      class DeployInfo
        class << self
          # @param hash [Hash]
          # @return [Avm::EacWebappBase0::Instances::DeployInfo]
          def from_hash(hash)
            new(hash)
          end

          # @return string [String]
          # @return [Avm::EacWebappBase0::Instances::DeployInfo]
          def from_string(string)
            from_hash(::EacRubyUtils::Yaml.load(string))
          end
        end

        common_constructor :data do
          self.data = data.with_indifferent_access
        end

        # @return [Hash]
        delegate :to_h, to: :data

        # @return [String]
        def to_yaml
          ::EacRubyUtils::Yaml.dump(to_h)
        end
      end
    end
  end
end
