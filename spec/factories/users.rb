# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    currency { 'USD' }
    role { :user } # Currently default role for user

    trait :admin do
      role { :admin }
    end
  end
end
