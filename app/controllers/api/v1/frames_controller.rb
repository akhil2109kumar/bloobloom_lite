# frozen_string_literal: true

module Api
  module V1
    # api/v1/frames_controller.rb
    class FramesController < ApplicationController
      before_action :set_frame, only: %i[show]

      def index
        frames = current_user.admin? ? Frame.includes(:prices).all : Frame.includes(:prices).active
        _, @frames = pagy(frames, page: params[:page])
        render json: @frames, each_serializer: FrameSerializer, status: :ok
      end

      def show
        render json: @frame, serializer: FrameSerializer, status: :ok
      end

      private

      def set_frame
        @frame = Frame.find_by(id: params[:id])
        render json: { message: 'Frame Not Found' }, status: :not_found unless @frame.present?
      end
    end
  end
end
