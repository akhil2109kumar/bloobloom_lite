# frozen_string_literal: true

class LensService < BaseService
  attr_reader :lens_params

  def initialize(lens_params = nil)
    super()
    @lens_params = lens_params
  end

  def create
    unless lens_params[:prices_attributes].present?
      fail!('Please Provide Price and Currency')
      return
    end

    @lens = Lens.new(lens_params)
    if @lens.save
      success!(@lens)
    else
      fail!(@lens.errors.full_messages)
    end
  end

  def update(lens)
    if lens.update(lens_params)
      success!(lens)
    else
      fail!(lens.errors.full_messages)
    end
  end

  def destroy(lens)
    if lens.destroy
      success!(lens)
    else
      fail!(lens.errors.full_messages)
    end
  end
end
