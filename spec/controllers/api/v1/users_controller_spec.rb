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

      context 'when email already exists' do
        let(:email) { 'sample@email.co' }

        let(:user_params) do
          { email: email.downcase }
        end

        let(:duplicated_user_params) do
          { email: email.upcase }
        end

        before do
          post :create, format: :json, user: user_params
        end

        it 'is :unprocessable_entity' do
          post :create, format: :json, user: duplicated_user_params

          is_expected.to respond_with(:unprocessable_entity)
        end
      end
    end

    context 'valid request' do
      let(:user_params) do
        { email: 'sample@sample.co' }
      end

      it 'is :created' do
        post :create, format: :json, user: user_params

        is_expected.to respond_with(:created)
      end
    end
  end
end
