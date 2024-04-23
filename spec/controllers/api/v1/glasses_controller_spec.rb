# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GlassesController, type: :controller do
  let(:user) { create(:user) }
  let(:frame) { create(:frame, status: 'active') }
  let(:lens) { create(:lens) }
  let(:out_of_stock_lens) { create(:lens, stock: 0) }
  let(:valid_params) do
    {
      glass: {
        frame_id: frame.id,
        lens_id: lens.id
      }
    }
  end

  let(:invalid_params) do
    {
      glass: {
        frame_id: 'xyz',
        lens_id: 'abc'
      }
    }
  end

  let(:out_of_stock_params) do
    {
      glass: {
        frame_id: frame.id,
        lens_id: out_of_stock_lens.id
      }
    }
  end

  describe 'POST #create' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'returns http status created with valid params' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'returns the created glass data' do
        post :create, params: valid_params
        json_response = JSON.parse(response.body)
        expect(json_response['frame']['id']).to eq(frame.id)
        expect(json_response['lens']['id']).to eq(lens.id)
      end

      it 'returns http status unprocessable_entity if frame or lens not exist' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to eq('Lens not found')
      end

      it 'returns http status unprocessable_entity if frame or lens out of stock' do
        post :create, params: out_of_stock_params
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to eq('Selected Lens is out of stock!!')
      end
    end

    context 'when user is not logged in' do
      it 'returns http status unauthorized' do
        post :create, params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
