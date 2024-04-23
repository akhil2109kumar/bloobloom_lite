# app/models/glass.rb
class Glass < ApplicationRecord
  belongs_to :frame
  belongs_to :lens
  belongs_to :shopping_basket, optional: true
end
