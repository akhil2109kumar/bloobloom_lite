# frozen_string_literal: true

FactoryBot.define do
  factory :frame do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    status { 'active' }
    stock { 10 }

    after(:build) do |frame|
      frame.prices << build(:price)
    end
  end
end
