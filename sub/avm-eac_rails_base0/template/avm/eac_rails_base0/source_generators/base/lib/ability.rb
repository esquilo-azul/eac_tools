# frozen_string_literal: true

class Ability < ::EacRailsBase0::AppBase::Ability
  def initialize(user)
    super(user)
    user ||= ::EacUsersSupport::User.new
    for_all_permissions(user)
    logged_permissions(user) unless user.new_record?
  end

  private

  def for_all_permissions(_user)
    can :read, :welcome
  end

  def logged_permissions(_user)
    can :manage, :all
  end
end
