# frozen_string_literal: true

# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without a currency' do
      user.currency = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with an invalid currency' do
      user.currency = 'ABC'
      expect(user).not_to be_valid
      expect(user.errors[:currency]).to include('ABC is not a valid currency')
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      duplicate_user = build(:user, email: user.email)
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors[:email]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it { should have_one(:shopping_basket) }
    it { should have_many(:glasses).through(:shopping_basket) }
  end
end
