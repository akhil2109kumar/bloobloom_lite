# frozen_string_literal: true

module Api
  module V1
    module Admin
      # api/v1/admin/base_controller.rb
      class BaseController < ApplicationController
        before_action :authenticate_admin

        private

        def authenticate_admin
          render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user&.admin?
        end
      end
    end
  end
end
