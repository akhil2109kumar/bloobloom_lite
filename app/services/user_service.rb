# frozen_string_literal: true

# user_service.rb
class UserService < BaseService
  def create(user_params)
    user = User.new(user_params)
    if user.save
      token = jwt_encode(user_id: user.id)
      success!({ user:, token: })
    else
      fail!(user.errors.full_messages)
    end
  end
end
