# frozen_string_literal: true

class Module
  # @return [EacTemplates::Modules::Base]
  def eac_template
    @eac_template ||= ::EacTemplates::Modules::Base.new(self)
  end
end
