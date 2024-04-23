# frozen_string_literal: true

FactoryBot.define do
  factory :shopping_basket do
    association :user
    trait :with_glasses do
      after(:create) do |shopping_basket|
        create_list(:glass, 3, shopping_basket:)
      end
    end
  end
end
