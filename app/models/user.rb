# frozen_string_literal: true

# The User model represents a user in the application.
class User < ApplicationRecord
  has_secure_password

  include UserAttributes
  has_one :shopping_basket
  has_many :glasses, through: :shopping_basket
end
