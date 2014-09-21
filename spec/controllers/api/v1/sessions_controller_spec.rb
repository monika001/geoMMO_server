require 'rails_helper'

describe Api::V1::SessionsController do
  let(:user) { create(:user) }

  describe '#create' do
    context 'when anonymous user' do
      before do
        post :create, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }

      it 'returns errors messages' do
        expect(json_response[:errors]).not_to be_empty
      end
    end

    context 'with invalid credentials' do
      let(:session_params) do
        { email: '' }
      end

      before  do
        post :create, session: session_params, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }

      it 'returns errors messages' do
        expect(json_response[:errors]).not_to be_empty
      end
    end

    context 'with valid credentials' do
      let(:session_params) do
        { email: user.email }
      end

      before do
        post :create, session: session_params, format: :json
      end

      it { is_expected.to respond_with(:ok) }

      it 'returns token' do
        expect(json_response[:session][:token]).to eq token_of(user)
      end
    end
  end

  describe '.destroy' do
    before do
      add_user_to_session(user)
    end

    context 'when anonymous user' do
      before do
        delete :destroy, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }

      it 'returns errors messages' do
        expect(json_response[:errors]).not_to be_empty
      end
    end

    context 'with valid token' do
      before  do
        add_token_to_header_of(user)
        delete :destroy, format: :json
      end

      it { is_expected.to respond_with(:no_content) }
    end
  end
end
