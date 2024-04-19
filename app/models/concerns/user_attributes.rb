# frozen_string_literal: true

# app/models/concerns/user_attributes.rb
module UserAttributes
  extend ActiveSupport::Concern

  included do
    enum role: { user: 0, admin: 1 }

    validates :name, :currency, :email, presence: true
    validates :email, uniqueness: true
    validates :password_confirmation, presence: true, on: :create
    validates :currency, presence: true,
                         inclusion: { in: %w[USD GBP EUR JOD JPY], message: '%<value>s is not a valid currency' }
  end
end
