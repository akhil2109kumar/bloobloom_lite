# frozen_string_literal: true

# app/models/glass.rb
class Glass < ApplicationRecord
  belongs_to :frame
  belongs_to :lens
  belongs_to :shopping_basket, optional: true
  after_create :decrement_stock

  def price_in_currency(currency)
    frame.price_in_currency(currency) + lens.price_in_currency(currency)
  end

  def decrement_stock
    frame.decrement!(:stock, 1)
    lens.decrement!(:stock, 1)
  end
end
