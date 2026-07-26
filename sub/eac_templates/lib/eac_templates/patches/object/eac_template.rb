# frozen_string_literal: true

class Object
  # @!method eac_template
  #   @return (see Module#eac_template)
  delegate :eac_template, to: :class
end
