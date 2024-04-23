# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::LensesController, type: :controller do
  let(:admin_user) { create(:user, :admin) }
  let!(:lenses) { create_list(:lens, 3) }
  let(:lens) { lenses.first }

  describe 'when user is logged in as admin' do
    before do
      sign_in admin_user
    end

    describe 'GET #index' do
      it 'returns a list of lenses' do
        get :index
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(lenses.count)
      end

      it 'returns lenses with prices' do
        get :index
        json_response = JSON.parse(response.body)
        expect(json_response.first).to have_key('prices')
      end
    end

    describe 'GET #show' do
      it 'returns the requested lens' do
        get :show, params: { id: lens.id }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['id']).to eq(lens.id)
      end

      it 'returns not found if lens does not exist' do
        get :show, params: { id: -1 }
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Lens Not Found')
      end
    end
  end

  describe 'when user is not logged in' do
    describe 'GET #index' do
      it 'returns http status unauthorized' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'GET #show' do
      it 'returns http status unauthorized' do
        get :show, params: { id: lens.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
