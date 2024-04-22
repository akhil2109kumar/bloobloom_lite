# frozen_string_literal: true

module Api
  module V1
    # api/v1/users_controller.rb
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: :create

      def create
        service = ::UserService.new

        begin
          service.create(user_params)
        rescue ActionController::ParameterMissing => e
          return render json: { errors: e.message }, status: :bad_request
        end

        if service.success
          render json: {
            message: 'User created successfully',
            user: ::UserSerializer.new(service.data[:user]),
            token: service.data[:token]
          }, status: :created
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      def my_basket
        basket = ShoppingBasket.includes(glasses: %i[frame lens]).find_by(user_id: current_user.id)
        render json: basket, serializer: ShoppingBasketSerializer, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :currency)
      end
    end
  end
end
