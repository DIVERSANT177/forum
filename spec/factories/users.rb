FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.ru"
  end

  factory :user do
    email
    password { 'asd870412' }
    password_confirmation { 'asd870412' }
    role { 'admin' }
  end
end
