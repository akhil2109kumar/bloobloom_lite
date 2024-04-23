# frozen_string_literal: true

FactoryBot.define do
  factory :price do
    amount { 10 }
    currency { 'USD' }
  end
end
