# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  let!(:user) { create(:user) }

  describe 'POST #create' do
    context 'with valid credentials' do
      before do
        post :create, params: { user: { email: user.email, password: user.password } }
      end

      it 'returns http status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user data and token' do
        json_response = JSON.parse(response.body)
        expect(json_response['user']['email']).to eq(user.email)
        expect(json_response).to have_key('token')
      end
    end

    context 'with invalid credentials' do
      before do
        post :create, params: { user: { email: user.email, password: 'wrongpassword' } }
      end

      it 'returns http status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('error')
      end
    end

    context 'with missing parameters' do
      before do
        post :create, params: { user: { email: user.email } }
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('error')
      end
    end
  end
end
