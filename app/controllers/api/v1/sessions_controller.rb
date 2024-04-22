# frozen_string_literal: true

module Api
  module V1
    # api/v1/sessions_controller.rb
    class SessionsController < ApplicationController
      skip_before_action :authenticate_user

      def create
        service = ::SessionService.new
        begin
          service.create(session_params)
        rescue ActionController::ParameterMissing => e
          return render json: { error: e.message }, status: :bad_request
        end

        if service.success
          render json: {
            user: ::UserSerializer.new(service.data[:user]),
            token: service.data[:token]
          }, status: :ok
        else
          render json: { error: service.errors }, status: :unauthorized
        end
      end

      private

      def session_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
