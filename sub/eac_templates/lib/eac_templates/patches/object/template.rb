# frozen_string_literal: true

class Object
  delegate :template, to: :class
end
