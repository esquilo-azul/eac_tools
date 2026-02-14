# frozen_string_literal: true

require 'eac_ruby_utils/simple_cache'

class AbilityMapping < ::EacRailsBase0::AppBase::AbilityMapping
  def initialize
    super
    map_action 'Welcome', 'index', :read, :welcome
  end
end
