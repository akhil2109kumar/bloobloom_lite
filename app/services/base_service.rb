# frozen_string_literal: true

# base_service.rb
class BaseService
  include JsonWebToken
  attr_accessor :success, :data, :errors

  def initialize
    @success = false
  end

  def call
    raise NotImplementedError, 'The #call method must be implemented in subclasses'
  end

  protected

  def success!(data)
    self.success = true
    self.data = data
  end

  def fail!(errors)
    self.errors = errors
  end
end
