# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Admin::FramesController, type: :controller do
  let(:admin_user) { create(:user, :admin) }
  let!(:frame) { create(:frame) }

  describe 'when user is logged in' do
    before do
      sign_in admin_user
    end
    describe 'POST #create' do
      context 'with valid params' do
        let(:valid_params) do
          {
            frame: attributes_for(:frame).merge(
              prices_attributes: [
                attributes_for(:price)
              ]
            )
          }
        end

        it 'creates a new frame' do
          expect do
            post :create, params: valid_params
          end.to change(Frame, :count).by(1)
        end

        it 'returns http status created' do
          post :create, params: valid_params
          expect(response).to have_http_status(:created)
        end

        it 'returns the newly created frame' do
          post :create, params: valid_params
          json_response = JSON.parse(response.body)
          expect(json_response['name']).to eq(valid_params[:frame][:name])
        end
      end

      context 'with invalid params' do
        let(:invalid_params) do
          {
            frame: {
              name: nil,
              description: nil,
              status: 'active',
              stock: -5
            }
          }
        end

        it 'does not create a new frame' do
          expect do
            post :create, params: invalid_params
          end.not_to change(Frame, :count)
        end

        it 'returns http status unprocessable_entity' do
          post :create, params: invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error messages' do
          post :create, params: invalid_params
          json_response = JSON.parse(response.body)
          expect(json_response).to have_key('errors')
        end
      end
    end

    describe 'PATCH #update' do
      context 'with valid params' do
        let(:valid_params) do
          {
            id: frame.id,
            frame: {
              name: 'Updated Frame',
              description: 'Updated description of the frame'
            }
          }
        end

        it 'updates the frame' do
          patch :update, params: valid_params
          frame.reload
          expect(frame.name).to eq('Updated Frame')
          expect(frame.description).to eq('Updated description of the frame')
        end

        it 'returns http status ok' do
          patch :update, params: valid_params
          expect(response).to have_http_status(:ok)
        end

        it 'returns the updated frame' do
          patch :update, params: valid_params
          json_response = JSON.parse(response.body)
          expect(json_response['name']).to eq('Updated Frame')
        end
      end

      context 'with invalid params' do
        let(:invalid_params) do
          {
            id: frame.id,
            frame: {
              name: nil,
              description: nil
            }
          }
        end

        it 'does not update the frame' do
          patch :update, params: invalid_params
          frame.reload
          expect(frame.name).not_to be_nil
          expect(frame.description).not_to be_nil
        end

        it 'returns http status unprocessable_entity' do
          patch :update, params: invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error messages' do
          patch :update, params: invalid_params
          json_response = JSON.parse(response.body)
          expect(json_response).to have_key('errors')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes the frame' do
        expect do
          delete :destroy, params: { id: frame.id }
        end.to change(Frame, :count).by(-1)
      end

      it 'returns http status ok' do
        delete :destroy, params: { id: frame.id }
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        delete :destroy, params: { id: frame.id }
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Successfully Destroyed')
      end
    end
  end

  describe 'when user is not logged in' do
    describe 'POST #create' do
      let(:valid_params) do
        {
          frame: attributes_for(:frame).merge(
            prices_attributes: [
              attributes_for(:price)
            ]
          )
        }
      end

      it 'returns http status unauthorized' do
        post :create, params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'PATCH #update' do
      let(:valid_params) do
        {
          id: frame.id,
          frame: {
            name: 'Updated Frame',
            description: 'Updated description of the frame'
          }
        }
      end

      it 'returns http status unauthorized' do
        patch :update, params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'DELETE #destroy' do
      it 'returns http status unauthorized' do
        delete :destroy, params: { id: frame.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
