# frozen_string_literal: true

class FrameService < BaseService
  attr_reader :frame_params

  def initialize(frame_params = nil)
    super()
    @frame_params = frame_params
  end

  def create
    unless frame_params[:prices_attributes].present?
      fail!('Please Provide Price and Currency')
      return
    end

    @frame = Frame.new(frame_params)
    if @frame.save
      success!(@frame)
    else
      fail!(@frame.errors.full_messages)
    end
  end

  def update(frame)
    if frame.update(frame_params)
      success!(frame)
    else
      fail!(frame.errors.full_messages)
    end
  end

  def destroy(frame)
    if frame.destroy
      success!(frame)
    else
      fail!(frame.errors.full_messages)
    end
  end
end
