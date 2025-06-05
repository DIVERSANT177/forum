require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
  let(:user) { nil }
  it { should be_able_to :read, Question }
  it { should be_able_to :read, Answer }
  it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user }

    it { should be_able_to :manage, Question }
  end

  describe 'for user' do
    let(:user) { create :user, :usually }

    it { should be_able_to :manage, Answer }

    it { should_not be_able_to :manage, Question }
  end
end
