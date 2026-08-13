# frozen_string_literal: true

module EacDocker
  class Container
    module Identifiers
      attr_reader :id

      protected

      attr_writer :id
    end
  end
end
