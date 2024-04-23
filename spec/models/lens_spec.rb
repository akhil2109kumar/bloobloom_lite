# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lens, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:colour) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:stock) }

    it 'is valid with valid attributes' do
      lens = build(:lens)
      expect(lens).to be_valid
    end

    it 'validates presence of colour, description, prescription_type, lens_type, and stock' do
      lens = build(:lens, colour: nil, description: nil, prescription_type: nil, lens_type: nil,
                          stock: nil)
      expect(lens).not_to be_valid
      expect(lens.errors[:colour]).to include("can't be blank")
      expect(lens.errors[:description]).to include("can't be blank")
      expect(lens.errors[:prescription_type]).to include(' is not a valid prescription type')
      expect(lens.errors[:lens_type]).to include(' is not a valid lens type')
      expect(lens.errors[:stock]).to include("can't be blank")
    end

    it 'validates numericality of stock' do
      lens = build(:lens, stock: -1)
      expect(lens).not_to be_valid
      expect(lens.errors[:stock]).to include('must be greater than or equal to 0')
    end
  end

  describe 'associations' do
    it { should have_many(:prices).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it 'accepts nested attributes for prices' do
      lens = build(:lens)
      expect(lens).to respond_to(:prices_attributes=)
    end
  end

  describe 'callbacks' do
    it 'calls build_prices after create' do
      lens = build(:lens)
      expect(lens).to receive(:build_prices)
      lens.save
    end
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:prices).allow_destroy(true) }
  end

  describe 'methods' do
    let(:lens) { create(:lens) }
    let(:currency) { 'GBP' }

    describe '#price_in_currency' do
      it 'returns the correct price for the given currency' do
        expect(lens.price_in_currency(currency)).to eq(lens.prices.find_by(currency:).amount)
      end
    end
  end

  describe 'callbacks' do
    it 'triggers #build_prices after create' do
      lens = build(:lens)

      expect(lens).to receive(:build_prices)

      lens.save!
    end
  end
end
