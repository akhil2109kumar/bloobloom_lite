# frozen_string_literal: true

# session_service.rb
class SessionService < BaseService
  def create(session_params)
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      token = jwt_encode(user_id: user.id)
      success!({ user:, token: })
    else
      fail!('Unauthorized')
    end
  end
end
