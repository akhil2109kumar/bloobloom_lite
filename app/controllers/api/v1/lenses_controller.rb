# frozen_string_literal: true

module Api
  module V1
    class LensesController < ApplicationController
      before_action :set_frame, only: %i[show]

      def index
        lenses = Lens.includes(:prices).all
        _, @lenses = pagy(lenses, page: params[:page])
        render json: @lenses, each_serializer: LensSerializer, status: :ok
      end

      def show
        render json: @lens, serializer: LensSerializer, status: :ok
      end

      private

      def set_frame
        @lens = Lens.find_by(id: params[:id])
        render json: { message: 'Lens Not Found' }, status: :not_found unless @lens.present?
      end
    end
  end
end
