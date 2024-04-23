# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Frame, type: :model do
  describe 'associations' do
    it { should have_many(:prices).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:stock) }
    it { should validate_numericality_of(:stock).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:prices).allow_destroy(true) }
  end

  describe 'methods' do
    let(:frame) { create(:frame) }
    let(:currency) { 'GBP' }

    describe '#price_in_currency' do
      it 'returns the correct price for the given currency' do
        expect(frame.price_in_currency(currency)).to eq(frame.prices.find_by(currency:).amount)
      end
    end
  end

  describe 'callbacks' do
    it 'triggers #build_prices after create' do
      frame = build(:frame)

      expect(frame).to receive(:build_prices)

      frame.save!
    end
  end
end
