# frozen_string_literal: true

# frame_serializer.rb
class FrameSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status, :stock, :price
  attribute :price, unless: :admin_user?
  attribute :currency, unless: :admin_user?
  has_many :prices, serializer: PriceSerializer, if: :admin_user?

  def price
    object.price_in_currency(current_user.currency)
  end

  def currency
    current_user.currency
  end

  def admin_user?
    current_user.admin?
  end
end
