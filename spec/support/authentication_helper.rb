# frozen_string_literal: true

# support/authentication_helper.rb

module AuthenticationHelper
  include JsonWebToken

  def sign_in(user)
    payload = { user_id: user.id }
    token = jwt_encode(payload)
    request.headers['Authorization'] = "Bearer #{token}"
  end
end
