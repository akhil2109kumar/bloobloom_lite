# frozen_string_literal: true

# application_controller.rb
class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_user
end
