# frozen_string_literal: true

# app/serializers/shopping_basket_serializer.rb
class ShoppingBasketSerializer < ActiveModel::Serializer
  attributes :id, :total_price, :currency
  has_many :glasses, serializer: GlassSerializer

  def total_price
    object.grand_total_in_currency(current_user.currency)
  end

  def currency
    current_user.currency
  end
end
