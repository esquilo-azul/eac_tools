# frozen_string_literal: true

module EacTemplates
  module Sources
    class InternalSet < ::Set
      # @param single [EacTemplates::Sources::Single]
      # @return [self]
      def add(single)
        super(::EacTemplates::Sources::Single.assert(single))
      end

      # @param single [EacTemplates::Sources::Single]
      # @return [self]
      def <<(single)
        add(single)
      end

      # @return [String]
      def to_s
        "#{self.class.name}[#{join(', ')}]"
      end
    end
  end
end
