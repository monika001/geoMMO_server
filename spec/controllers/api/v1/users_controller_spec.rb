require 'rails_helper'

describe Api::V1::UsersController do
  describe '#show' do
    context 'unauthorized user' do
      it_behaves_like 'unauthorized user', :get, :show
    end

    context 'authorized user' do
      let(:user) { create(:user) }

      before do
        log_in user

        get :show, format: :json
      end

      it { is_expected.to respond_with :ok }

      it_behaves_like 'current user'
    end
  end

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
        user = User.create(unprocessable_user_params)

        expect(json_response[:errors]).to eq user.errors.full_messages
      end
    end

    context 'valid request' do
      let(:user_params) do
        { email: 'sample@sample.co' }
      end

      let(:user) { User.find_by(user_params) }

      before do
        post :create, format: :json, user: user_params
      end

      it { is_expected.to respond_with :created }

      it_behaves_like 'current user'
    end
  end

  describe '#destroy' do
    context 'when anonymous user' do
      it_behaves_like 'unauthorized user', :delete, :destroy
    end

    context 'when self' do
      let(:user) { create(:user) }

      before do
        log_in user
        delete :destroy, format: :json
      end

      it { is_expected.to respond_with(:no_content) }

      it 'deletes user from session' do
        expect(token_of(user)).to be nil
      end

      it 'removes user from db' do
        expect(User.find_by id: user.id).to be nil
      end
    end
  end
end
