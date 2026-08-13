# frozen_string_literal: true

module EacDocker
  class Container
    module Identifiers
      common_concern do
        immutable_accessor :name, type: :common
      end

      attr_reader :id

      # Value that identifies the container to Docker commands: {#id}, if present, or {#name}.
      #
      # @return [String]
      def identifier
        id.presence || name.presence || raise('Neither `id` or `name` is present ' \
                                              '- need at least one of them')
      end

      protected

      attr_writer :id
    end
  end
end
