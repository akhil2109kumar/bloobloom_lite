# frozen_string_literal: true

# spec/models/shopping_basket_spec.rb

require 'rails_helper'

RSpec.describe ShoppingBasket, type: :model do
  describe 'associations' do
    it 'has many glasses' do
      is_expected.to have_many(:glasses)
    end

    it 'belongs to a user' do
      is_expected.to belong_to(:user)
    end
  end

  describe '#grand_total_in_currency' do
    let(:user) { create(:user, currency: 'USD') }
    let(:shopping_basket) { create(:shopping_basket, user:) }
    let!(:glasses) do
      create_list(:glass, 2, frame: create(:frame), lens: create(:lens), shopping_basket:)
    end

    it 'calculates the grand total in the specified currency' do
      expected_total = glasses.first.price_in_currency('USD') + glasses.second.price_in_currency('USD')
      expect(shopping_basket.grand_total_in_currency('USD')).to eq(expected_total)
    end
  end
end
