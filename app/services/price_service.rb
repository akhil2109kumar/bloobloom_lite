# frozen_string_literal: true

# price_service.rb
class PriceService < BaseService
  attr_reader :object

  def initialize(object)
    super()
    @object = object
  end

  def build_prices_in_different_currencies
    provided_price = object.prices.first
    provided_money = Money.new(provided_price.amount * 100, provided_price.currency)

    Price::CURRENCIES.each do |currency|
      next if currency == provided_price.currency

      converted_price = provided_money.exchange_to(currency)
      object.prices.build(currency:, amount: converted_price)
    end
    object.save
  end
end
