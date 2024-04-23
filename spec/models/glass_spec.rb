# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Glass, type: :model do
  let!(:frame) { create(:frame, stock: 5) }
  let!(:lens) { create(:lens, stock: 5) }
  let!(:glass) { create(:glass, frame:, lens:) }

  describe 'associations' do
    it { should belong_to(:frame) }
    it { should belong_to(:lens) }
    it { should belong_to(:shopping_basket).optional }
  end

  describe '#price_in_currency' do
    it 'calculates the total price in the specified currency' do
      usd_price = frame.price_in_currency('USD') + lens.price_in_currency('USD')
      expect(glass.price_in_currency('USD')).to eq(usd_price)

      gbp_price = frame.price_in_currency('GBP') + lens.price_in_currency('GBP')
      expect(glass.price_in_currency('GBP')).to eq(gbp_price)

      eur_price = frame.price_in_currency('EUR') + lens.price_in_currency('EUR')
      expect(glass.price_in_currency('EUR')).to eq(eur_price)
    end
  end

  describe '#decrement_stock' do
    it 'decrements the stock of frame and lens by 1' do
      frame_stock_before = frame.stock
      lens_stock_before = lens.stock

      glass.decrement_stock

      expect(frame.reload.stock).to eq(frame_stock_before - 1)
      expect(lens.reload.stock).to eq(lens_stock_before - 1)
    end
  end
end
