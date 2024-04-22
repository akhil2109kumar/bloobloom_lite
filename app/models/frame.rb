# frozen_string_literal: true

# models/frame.rb
class Frame < ApplicationRecord
  enum status: { inactive: 0, active: 1 }

  validates :name, :status, presence: true
  validates :stock, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :prices, as: :priceable, dependent: :destroy

  accepts_nested_attributes_for :prices, allow_destroy: true
end
