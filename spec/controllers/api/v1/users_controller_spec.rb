require 'rails_helper'

describe Api::V1::UsersController do
  shared_examples_for 'respond with current user' do
    it 'returns current_user id' do
      expect(json_response[:user][:id]).to eq user.id
    end

    it 'returns current_user email' do
      expect(json_response[:user][:email]).to eq user.email
    end

    it 'returns current_user first_name' do
      expect(json_response[:user][:first_name]).to eq user.first_name
    end

    it 'returns current_user last_name' do
      expect(json_response[:user][:last_name]).to eq user.last_name
    end
  end

  describe '#show' do
    context 'unauthorized user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          get :show
        end
      end
    end

    context 'authorized user' do
      let(:user) { create(:user) }

      before do
        log_in user

        get :show
      end

      it { is_expected.to respond_with :ok }

      it_behaves_like 'respond with current user'
    end
  end

  describe '#create' do
    context 'when unprocessable entity' do
      it_behaves_like 'unprocessable entity' do
        let(:do_request) do
          post :create, user: { email: 'sample@sample.com' }
        end
      end

      it_behaves_like 'unprocessable entity' do
        let(:do_request) do
          post :create, user: { email: 'sample@sample.com', password: 'samplePassword123' }
        end
      end
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
        post :create, user: user_params
      end

      it { is_expected.to respond_with :created }

      it_behaves_like 'respond with location header'
      it_behaves_like 'respond with current user'
    end
  end


  describe '#update' do
    let!(:user) { create :user }

    context 'when anonymous user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          put :update
        end
      end
    end

    context 'when authorized user' do
      before do
        log_in user
      end

      context 'unprocessable user request' do
        it_behaves_like 'unprocessable entity' do
          let(:do_request) do
            put :update, id: user.id, user: { password: 'newPassword123' }
          end
        end

        it_behaves_like 'unprocessable entity' do
          let(:do_request) do
            put :update, id: user.id, user: { password: 'newPassword123', password_confirmation: 'mistype' }
          end
        end

        it_behaves_like 'unprocessable entity' do
          let(:do_request) do
            put :update, id: user.id, user: { email: 'sample@sample.com', password: 'samplePassword123' }
          end
        end
      end

      context 'when valid request' do
        shared_examples_for 'valid request' do |user_params, changed_column|
          context "on #{changed_column} change" do
            let(:do_request) do
              put :update, id: user.id, user: user_params
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

        it_behaves_like 'valid request',
          { password: 'newPassword123', password_confirmation: 'newPassword123' },
          :password_digest

        it_behaves_like 'valid request', { first_name: 'Sample' }, :first_name
      end
    end
  end

  describe '#destroy' do
    context 'when anonymous user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          delete :destroy
        end
      end
    end

    context 'when self' do
      let(:user) { create(:user) }

      before do
        log_in user
        delete :destroy
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
