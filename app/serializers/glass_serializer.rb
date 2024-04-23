# frozen_string_literal: true

# app/serializers/glasses_serializer.rb
class GlassSerializer < ActiveModel::Serializer
  attributes :id, :frame, :lens, :price
  has_one :frame, serializer: FrameSerializer
  has_one :lens, serializer: LensSerializer

  def price
    object.price_in_currency(current_user.currency)
  end
end
