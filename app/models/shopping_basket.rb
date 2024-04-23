# app/models/shopping_basket.rb
class ShoppingBasket < ApplicationRecord
  has_many :glasses
  belongs_to :user

end
