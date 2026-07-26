# frozen_string_literal: true

module Dashed
  module Mygem
    module Self
      class << self
        def application
          @application ||= ::EacRubyBase0::Application.new(::File.expand_path('../../..', __dir__))
        end
      end
    end
  end
end
