# frozen_string_literal: true

# The User model represents a user in the application.
class User < ApplicationRecord
  has_secure_password

  include UserAttributes
end
