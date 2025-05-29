FactoryBot.define do
  factory :answer do
    title { "MyString" }
    body { "MyText" }
  end

  trait :invalid do
    title { nil }
    body { nil }
  end
end
