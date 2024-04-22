# frozen_string_literal: true

require 'jwt'
# lib/json_web_token.rb
module JsonWebToken
  SECRET_KEY = Rails.application.secret_key_base

  def jwt_encode(payload, exp = 1.day.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def jwt_decode(token)
    decode = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decode)
  rescue JWT::DecodeError
    nil
  end

  def decoded_token
    token = request.headers['Authorization']
    return unless token

    jwt_decode(token)
  end

  def current_user
    @current_user ||= User.find_by(id: decoded_token&.[](:user_id))
  end

  def authenticate_user
    token = request.headers['Authorization']&.split&.last
    if token
      payload = jwt_decode(token)
      if payload
        @current_user = User.find_by(id: payload[:user_id])
        return if @current_user
      end
    end
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
