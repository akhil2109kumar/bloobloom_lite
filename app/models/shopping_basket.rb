# frozen_string_literal: true

# app/models/shopping_basket.rb
class ShoppingBasket < ApplicationRecord
  has_many :glasses
  belongs_to :user

  def grand_total_in_currency(currency)
    glasses.map { |g| g.price_in_currency(currency) }&.sum
  end
end
