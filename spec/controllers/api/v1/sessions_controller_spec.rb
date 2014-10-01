require 'rails_helper'

describe Api::V1::SessionsController do
  let(:user) { create(:user) }

  describe '#create' do
    context 'when anonymous user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          post :create
        end
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
        {
          email: user.email,
          password: user.password
        }
      end

      before do
        post :create, session: session_params, format: :json
      end

      it { is_expected.to respond_with(:ok) }

      it 'returns token' do
        user.reload
        expect(json_response[:session][:token]).to eq user.token
      end
    end
  end

  describe '.destroy' do
    before do
      add_user_to_session(user)
    end

    context 'when anonymous user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          delete :destroy
        end
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
