require 'rails_helper'

describe Api::V1::LocationsController do
  let(:user) { create :user }
  let(:character) { create(:character, user: user) }

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

  describe 'GET #show'
end
