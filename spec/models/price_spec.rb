# frozen_string_literal: true

# spec/models/price_spec.rb
require 'rails_helper'

RSpec.describe Price, type: :model do
  let(:frame) { build(:frame) }
  let(:price) { build(:price, priceable: frame) }

  describe 'associations' do
    it { should belong_to(:priceable) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(price).to be_valid
    end

    it 'is invalid without an amount' do
      price.amount = nil
      expect(price).not_to be_valid
      expect(price.errors[:amount]).to include("can't be blank")
    end

    it 'is invalid without a currency' do
      price.currency = nil
      expect(price).not_to be_valid
      expect(price.errors[:currency]).to include("can't be blank")
    end

    it 'is invalid with an unsupported currency' do
      price.currency = 'XYZ'
      expect(price).not_to be_valid
      expect(price.errors[:currency]).to include('XYZ is not a valid currency')
    end
  end

  describe 'CURRENCIES constant' do
    it 'contains the expected currencies' do
      expected_currencies = %w[USD GBP EUR JOD JPY]
      expect(Price::CURRENCIES).to eq(expected_currencies)
    end
  end
end
