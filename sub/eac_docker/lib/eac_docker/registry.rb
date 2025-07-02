# frozen_string_literal: true

module EacDocker
  class Registry
    common_constructor :name

    def to_s
      name
    end

    def sub(suffix)
      self.class.new("#{name}#{suffix}")
    end
  end
end
