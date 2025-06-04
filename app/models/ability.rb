# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Question
    can :read, Answer

    return unless user.present?
    can :manage, Answer, user: user

    return unless user.admin?
    can :manage, Question, user: user
  end
end
