# frozen_string_literal: true

# application_controller.rb
class ApplicationController < ActionController::API
  include JsonWebToken
  include Pagy::Backend

  before_action :authenticate_user
end
