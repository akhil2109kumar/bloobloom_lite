# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/glasses_controller.rb
    class GlassesController < ApplicationController
      def create
        service = GlassesService.new(glass_params, current_user)
        service.create_glasses
        if service.success
          render json: service.data, each_serializer: GlassSerializer, status: :created
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      private

      def glass_params
        params.require(:glass).permit(:frame_id, :lens_id)
      end
    end
  end
end
