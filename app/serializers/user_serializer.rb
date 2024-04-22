# frozen_string_literal: true

# user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :currency
end
