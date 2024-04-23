# frozen_string_literal: true

class GlassesService < BaseService
  attr_accessor :params, :user, :frame, :lens, :basket

  def initialize(params, user)
    super()
    @params = params
    @user = user
    @basket = set_basket
  end

  def create_glasses
    ActiveRecord::Base.transaction do
      validate_and_set_frame
      validate_and_set_lens
      return unless lens && frame

      unless frame.stock?
        fail!('Selected Frame is out of stock!!')
        return
      end

      unless lens.stock?
        fail!('Selected Lens is out of stock!!')
        return
      end

      build_and_save_glass
    end
  rescue StandardError => e
    fail!("Unhandled Error: #{e.message}")
  end

  private

  def validate_and_set_frame
    @frame = Frame.find_by(id: params[:frame_id], status: 'active')
    fail!('Frame not found') unless @frame
  end

  def validate_and_set_lens
    @lens = Lens.find_by(id: params[:lens_id])
    fail!('Lens not found') unless @lens
  end

  def set_basket
    @basket = ShoppingBasket.find_or_create_by(user_id: user.id)
  end

  def build_and_save_glass
    glass = basket.glasses.build(frame:, lens:)
    if glass.save
      success!(glass)

    else
      fail!(glass.errors.full_messages)
      raise ActiveRecord::Rollback
    end
  end
end
