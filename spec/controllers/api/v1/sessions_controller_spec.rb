require 'rails_helper'

describe Api::V1::SessionsController do
  let(:user) { create(:user) }

  describe '#create' do
    context 'without credentials' do
      before do
        post :create, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    context 'with invalid credentials' do
      let(:credentials) do
        { email: '' }
      end

      before  do
        post :create, credentials: credentials, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    context 'with valid credentials' do
      let(:credentials) do
        { email: user.email }
      end

      before do
        post :create, credentials: credentials, format: :json
      end

      it { is_expected.to respond_with(:ok) }

    end
  end

  describe '.destroy' do
    before do
      add_user_to_session(user)
    end

    context 'with invalid token' do
      before do
        request.headers['HTTP_USER_API_TOKEN'] = 'invalid_token'
        delete :destroy, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    context 'with valid token' do
      before  do
        request.headers['HTTP_USER_API_TOKEN'] = token_of(user)
        delete :destroy, format: :json
      end

      it { is_expected.to respond_with(:ok) }
    end
  end
end
