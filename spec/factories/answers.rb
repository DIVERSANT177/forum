FactoryBot.define do
  factory :answer do
    title { "My answer" }
    body { "text" }
    user
  end

  trait :invalid do
    title { nil }
    body { nil }
    user
  end
end
