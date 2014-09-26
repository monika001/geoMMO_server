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

      it_behaves_like 'respond with current user'
    end
  end

  describe '#create' do
    context 'unprocessable user request' do
      shared_examples_for 'unprocessable user request' do |user_params|
        context "with params: #{user_params}" do
          before do
            post :create, format: :json, user: user_params
          end

          it { is_expected.to respond_with(:unprocessable_entity) }

          it 'respond with errors' do
            expect(json_response[:errors]).not_to be_empty
          end
        end
      end

      it_behaves_like 'unprocessable user request', { email: 'sample@sample.com' }
      it_behaves_like 'unprocessable user request', { email: 'sample@sample.com', password: 'samplePassword123' }
    end

    context 'valid request' do
      let(:user_params) do
        {
          email: 'sample@sample.com',
          password: 'sample123',
          password_confirmation: 'sample123'
        }
      end

      let(:user) { User.find_by email: user_params[:email] }

      before do
        post :create, format: :json, user: user_params
      end

      it { is_expected.to respond_with :created }

      it_behaves_like 'respond with location header'
      it_behaves_like 'respond with current user'
    end
  end


  describe '#update' do
    let!(:user) { create :user }

    context 'when anonymous user' do
      it_behaves_like 'unauthorized user', :put, :update
    end

    context 'unprocessable user request' do
      shared_examples_for 'unprocessable user request' do |user_params|
        context "with params: #{user_params}" do
          before do
            put :update, format: :json, id: user.id, user: user_params
          end

          it { is_expected.to respond_with(:unprocessable_entity) }

          it 'respond with errors' do
            expect(json_response[:errors]).to eq user.errors.full_messages
          end
        end
      end

      before do
        log_in user
      end

      it_behaves_like 'unprocessable user request', { password: 'newPassword123' }
      it_behaves_like 'unprocessable user request', { password: 'newPassword123', password_confirmation: 'mistype' }
      it_behaves_like 'unprocessable user request', { email: 'sample@sample.com', password: 'samplePassword123' }
    end

    context 'when valid request' do
      shared_examples_for 'valid request' do |user_params, changed_column|
        context "on #{changed_column} change" do
          let(:do_request) do
            put :update, format: :json, id: user.id, user: user_params
          end

          it 'respond with no content' do
            do_request
            is_expected.to respond_with :no_content
          end

          it 'updates user' do
            expect { do_request }.to change{ User.find(user.id).public_send(changed_column) }
          end
        end
      end

      before do
        log_in user
      end

      it_behaves_like 'valid request',
        { password: 'newPassword123', password_confirmation: 'newPassword123' },
        :password_digest

      it_behaves_like 'valid request', { first_name: 'Sample' }, :first_name
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
