FactoryBot.define do
  factory :answer do
    title { "MyString" }
    body { "MyText" }
    user
  end

  trait :invalid do
    title { nil }
    body { nil }
    user
  end
end
