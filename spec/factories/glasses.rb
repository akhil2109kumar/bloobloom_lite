# frozen_string_literal: true

FactoryBot.define do
  factory :glass do
    association :frame
    association :lens
    association :shopping_basket
  end
end
