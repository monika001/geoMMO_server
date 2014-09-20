require 'rails_helper'

describe Api::V1::UsersController do
  describe '#create' do
    context 'unprocessable user request' do
      let(:unprocessable_user_params) do
        { email: '' }
      end

      before do
        post :create, format: :json, user: unprocessable_user_params
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'respond with errors' do
        user_errors = User.create(unprocessable_user_params).errors
        expect(response.body).to eq user_errors.to_json
      end
    end

    context 'valid request' do
      let(:user_params) do
        { email: 'sample@sample.co' }
      end

      before do
        post :create, format: :json, user: user_params
      end

      it { is_expected.to respond_with :created }

      it 'returns id, uri and type of created model' do
        user = User.find_by email: user_params[:email]
        expected_response = { id: user.id, uri: api_v1_user_url(user), type: 'user' }
        response_hash = JSON.parse(response.body).symbolize_keys!

        expect(response_hash).to eq expected_response
      end
    end
  end

  describe '#destroy' do
    context 'when anonymous user' do
      before do
        delete :destroy, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    context 'when self' do
      let(:user) { create(:user) }

      before do
        log_in user
        delete :destroy, format: :json
      end

      it { is_expected.to respond_with(:ok) }

      it 'deletes user from session' do
        expect(token_of(user)).to be nil
      end

      it 'removes user from db' do
        expect(User.find_by id: user.id).to be nil
      end

      it 'returns email' do
        expect(json_response[:email]).to eq user.email
      end
    end
  end
end
