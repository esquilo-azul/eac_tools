# frozen_string_literal: true

module EacDocker
  class Container
    module Identifiers
      common_concern do
        immutable_accessor :name, type: :common
      end

      attr_reader :id

      protected

      attr_writer :id
    end
  end
end
