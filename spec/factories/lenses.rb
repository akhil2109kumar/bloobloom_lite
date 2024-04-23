# frozen_string_literal: true

FactoryBot.define do
  factory :lens do
    prescription_type { :fashion }
    lens_type { :classic }
    colour { 'Red' }
    description { Faker::Lorem.paragraph }
    stock { 10 }

    after(:build) do |frame|
      frame.prices << build(:price)
    end
  end
end
