require 'rails_helper'

describe Api::V1::LocationsController do
  let!(:user) { create :user }
  let!(:character) { create(:character, user: user) }

  describe 'PUT #update' do
    context 'when unauthorized user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) { put :update, character_id: character.id }
      end
    end

    context 'when authorized user' do
      before do
        log_in user
      end

      context 'when invalid request' do
        it_behaves_like 'bad request' do
          let(:do_request) { put :update, character_id: -1 }
        end
      end

      context 'when valid request' do
        let(:model_params) { attributes_for :location, longitude: 10 }

        before do
          put :update, character_id: character.id, location: model_params
          character.reload
        end

        it { is_expected.to respond_with :no_content }
        it { expect(character.location.longitude).to eq 10 }
      end
    end
  end

  describe 'GET #show' do
    context 'when unauthorized user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          get :show, character_id: character.id
        end
      end
    end

    context 'when authorized user' do
      before do
        log_in user
      end

      context 'when bad request' do
        it_behaves_like 'bad request' do
          let(:do_request) do
            get :show, character_id: -1
          end
        end
      end

      context 'when valid request' do
        let!(:location) { character.location }

        before do
          location.update latitude: 10, longitude: 20

          get :show, character_id: character.id
        end

        it { is_expected.to respond_with :ok }

        it { expect(json_response[:location][:id]).to eq location.id }
        it { expect(json_response[:location][:latitude]).to eq location.latitude }
        it { expect(json_response[:location][:longitude]).to eq location.longitude }
      end
    end
  end

  context 'nearby' do
    context 'when unauthorized user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          get :nearby, character_id: character.id
        end
      end
    end

    context 'when authorized user' do
      before do
        log_in user
      end

      context 'when bad request' do
        it_behaves_like 'bad request' do
          let(:second_user) { create :user, :with_character }
          let(:do_request) do
            get :nearby, character_id: second_user.characters.first.id
          end
        end

        it_behaves_like 'bad request' do
          let(:do_request) do
            get :nearby, character_id: -1
          end
        end
      end

      context 'when valid request' do
        let!(:second_user) { create :user, :with_character }
        let!(:third_user) { create :user, :with_character }

        before do
          get :nearby, character_id: user.characters.first.id
        end

        it { is_expected.to respond_with(:ok) }
        it { expect(json_response[:locations].length).to eq 2 }
      end
    end
  end
end
