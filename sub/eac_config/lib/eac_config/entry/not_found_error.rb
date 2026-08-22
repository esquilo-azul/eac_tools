# frozen_string_literal: true

module EacConfig
  class Entry
    class NotFoundError < ::RuntimeError
      def initialize(entry)
        super("Entry #{entry} not found")
      end
    end
  end
end
