FactoryBot.define do
  # factory :token do
  #   association :user, factory: [:user]
  #   key { u }
  # end

  factory :user do
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
  end

  factory :category do
    name { Faker::Types.rb_string }
  end

  factory :course do
    subject { Faker::Lorem.question }
    price { Faker::Number.within(range: 100.0..10000.0) }
    currency { Faker::Currency.code }
    launch { Faker::Boolean.boolean }
    url { Faker::Avatar.image }
    description { Faker::String.random }
    expire_day { Faker::Number.within(range: 1..30) }
  end
end