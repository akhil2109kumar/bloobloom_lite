# frozen_string_literal: true

# models/price.rb
class Price < ApplicationRecord
  CURRENCIES = %w[USD GBP EUR JOD JPY].freeze
  belongs_to :priceable, polymorphic: true

  validates :amount, presence: true
  validates :currency, presence: true,
                       inclusion: { in: %w[USD GBP EUR JOD JPY], message: '%<value>s is not a valid currency' }
end
