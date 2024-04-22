# frozen_string_literal: true

module Api
  module V1
    module Admin
      class LensesController < BaseController
        before_action :set_lens, except: :create

        def create
          service = LensService.new(lens_params)
          service.create

          if service.success
            render json: service.data, serializer: LensSerializer, status: :created
          else
            render json: { errors: service.errors }, status: :unprocessable_entity
          end
        end

        def update
          service = LensService.new(lens_params.except(:prices_attributes))
          service.update(@lens)

          if service.success
            render json: service.data, serializer: LensSerializer, status: :ok
          else
            render json: { errors: service.errors }, status: :unprocessable_entity
          end
        end

        def destroy
          service = LensService.new
          service.destroy(@lens)

          if service.success
            render json: { message: 'Successfully Destroyed' }, status: :ok
          else
            render json: { errors: result.errors }, status: :unprocessable_entity
          end
        end

        private

        def set_lens
          @lens = Lens.find_by(id: params[:id])
          render json: { message: 'Lens Not Found' }, status: :not_found unless @lens.present?
        end

        def lens_params
          params.require(:lens).permit(:description, :prescription_type, :lens_type,
                                       :colour, :stock, prices_attributes: %i[amount currency])
        end
      end
    end
  end
end
