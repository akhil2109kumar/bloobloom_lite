# frozen_string_literal: true

class Lens < ApplicationRecord
  self.table_name = 'lenses'

  enum prescription_type: { fashion: 0, single_vision: 1, varifocal: 2 }
  enum lens_type: { classic: 0, blue_light: 1, transition: 2 }

  validates :colour, :description,
            :prescription_type, :lens_type,
            :colour, presence: true

  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :prescription_type,
            inclusion: { in: prescription_types.keys,
                         message: '%<value>s is not a valid prescription type' }
  validates :lens_type, inclusion: { in: lens_types.keys, message: '%<value>s is not a valid lens type' }

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
