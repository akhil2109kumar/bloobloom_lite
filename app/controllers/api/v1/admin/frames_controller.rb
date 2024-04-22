# frozen_string_literal: true

module Api
  module V1
    module Admin
      # api/v1/admin/frames_controller.rb
      class FramesController < BaseController
        before_action :set_frame, except: :create

        def create
          service = FrameService.new(frame_params)
          service.create

          if service.success
            render json: service.data, serializer: FrameSerializer, status: :created
          else
            render json: { errors: service.errors }, status: :unprocessable_entity
          end
        end

        def update
          service = FrameService.new(frame_params.except(:prices_attributes))
          service.update(@frame)

          if service.success
            render json: service.data, serializer: FrameSerializer, status: :ok
          else
            render json: { errors: service.errors }, status: :unprocessable_entity
          end
        end

        def destroy
          service = FrameService.new
          service.destroy(@frame)

          if service.success
            render json: { message: 'Successfully Destroyed' }, status: :ok
          else
            render json: { errors: result.errors }, status: :unprocessable_entity
          end
        end

        private

        def set_frame
          @frame = Frame.find_by(id: params[:id])
          render json: { message: 'Frame Not Found' }, status: :not_found unless @frame.present?
        end

        def frame_params
          params.require(:frame).permit(:name, :description, :status, :stock,
                                        prices_attributes: %i[amount currency])
        end
      end
    end
  end
end
