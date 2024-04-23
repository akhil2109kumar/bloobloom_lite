# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Admin::LensesController, type: :controller do
  let!(:lens) { create(:lens) }
  let(:admin_user) { create(:user, :admin) }
  let(:non_admin_user) { create(:user) }

  before do
    sign_in admin_user
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          lens: attributes_for(:lens).merge(
            prices_attributes: [
              attributes_for(:price)
            ]
          )
        }
      end

      it 'creates a new lens' do
        expect do
          post :create, params: valid_params
        end.to change(Lens, :count).by(1)
      end

      it 'returns http status created' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'returns the newly created lens' do
        post :create, params: valid_params
        json_response = JSON.parse(response.body)
        expect(json_response['description']).to eq(valid_params[:lens][:description])
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          lens: {
            description: nil,
            status: 'active',
            stock: -5
          }
        }
      end

      it 'does not create a new lens' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Frame, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('errors')
      end
    end

    context 'when user is not admin' do
      before do
        sign_in non_admin_user
      end

      it 'returns http status unauthorized' do
        post :create, params: { lens: attributes_for(:lens) }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:valid_params) do
        {
          id: lens.id,
          lens: attributes_for(:lens, description: 'Updated description')
        }
      end

      it 'updates the lens' do
        patch :update, params: valid_params
        lens.reload
        expect(lens.description).to eq('Updated description')
      end

      it 'returns http status ok' do
        patch :update, params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not admin' do
      before do
        sign_in non_admin_user
      end

      it 'returns http status unauthorized' do
        patch :update, params: { id: lens.id, lens: attributes_for(:lens) }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is admin' do
      it 'deletes the lens' do
        expect do
          delete :destroy, params: { id: lens.id }
        end.to change(Lens, :count).by(-1)
      end

      it 'returns http status ok' do
        delete :destroy, params: { id: lens.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not admin' do
      before do
        sign_in non_admin_user
      end

      it 'returns http status unauthorized' do
        delete :destroy, params: { id: lens.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
