# frozen_string_literal: true

class Module
  def template
    @template ||= ::EacTemplates::Modules::Base.new(self)
  end
end
