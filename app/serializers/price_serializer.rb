# frozen_string_literal: true

# price_serializer.rb
class PriceSerializer < ActiveModel::Serializer
  attributes :amount, :currency
end
