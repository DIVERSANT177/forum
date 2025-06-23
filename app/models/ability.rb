# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can [ :read, :search ], Question
    can :read, Answer

    return unless user.present?
    can :manage, Answer, user: user
    can [ :like, :unlike ], Answer

    return unless user.admin?
    can :manage, Question, user: user
    can :manage, :all
  end
end
