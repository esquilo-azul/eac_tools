# frozen_string_literal: true

module EacDocker
  module Images
    class Base
      def container
        ::EacDocker::Container.new(self)
      end
    end
  end
end
