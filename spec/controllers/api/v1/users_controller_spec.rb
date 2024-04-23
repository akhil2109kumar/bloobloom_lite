# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        { user: { name: 'John Doe', email: 'john@example.com', password: 'password',
                  password_confirmation: 'password', currency: 'USD' } }
      end

      it 'creates a new user' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('User created successfully')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { user: { name: 'John Doe' } } }

      it 'returns a bad request status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("Email can't be blank")
        expect(JSON.parse(response.body)['errors']).to include("Password can't be blank")
      end
    end
  end

  describe 'GET #my_basket' do
    context 'when user is authenticated' do
      before(:each) do
        @user = create(:user)
        sign_in @user
      end

      let!(:shopping_basket) { create(:shopping_basket, user: @user) }

      it 'returns the user\'s shopping basket' do
        get :my_basket
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(shopping_basket.id)
      end
    end

    context 'when user is not authenticated' do
      it 'returns unauthorized status' do
        get :my_basket
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
