# frozen_string_literal: true

# models/frame.rb
class Frame < ApplicationRecord
  enum status: { inactive: 0, active: 1 }

  validates :name, :status, presence: true
  validates :stock, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :prices, as: :priceable, dependent: :destroy

  accepts_nested_attributes_for :prices, allow_destroy: true

  after_create :build_prices

  def price_in_currency(currency)
    prices.find { |p| p.currency == currency }&.amount
  end

  private

  def build_prices
    PriceService.new(self).build_prices_in_different_currencies
  end
end
