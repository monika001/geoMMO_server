require 'rails_helper'

describe Api::V1::CharactersController do
  let(:user) { create(:user) }

  shared_examples_for 'respond with character' do
    it 'returns character id' do
      expect(json_response[:character][:id]).not_to be_nil
    end

    it 'returns character name' do
      expect(json_response[:character][:name]).not_to be_empty
    end
  end

  describe 'POST create' do
    context 'when unauthorized user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          post :create
        end
      end
    end

    context 'when authorized user' do
      before do
        log_in user
      end

      context 'when unprocessable entity' do
        it_behaves_like 'unprocessable entity' do
          let(:do_request) do
            post :create, character: { name: ' ' }
          end
        end
      end

      context 'valid request' do
        let(:character_params) { attributes_for(:character) }

        before do
          post :create, character: character_params
        end

        it { is_expected.to respond_with :created }

        it_behaves_like 'respond with location header'
        it_behaves_like 'respond with character'
      end
    end
  end

  describe 'PUT update' do
    let!(:character) { create(:character, user: user) }

    context 'when unauthorized user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          put :update, id: character.id
        end
      end
    end

    context 'when authorized user' do
      before do
        log_in user
      end

      context 'when invalid request' do
        it_behaves_like 'bad request' do
          let(:do_request) do
            put :update, id: 123
          end
        end
      end

      context 'when unprocessable entity' do
        it_behaves_like 'unprocessable entity' do
          let(:do_request) do
            put :update, id: character.id, character: { name: ' ' }
          end
        end
      end

      context 'when valid request' do
        let(:model_params) do
          { name: Faker::Name.first_name }
        end

        let(:do_request) do
          put :update, id: character.id, character: model_params
        end

        it 'respond with no content' do
          do_request
          is_expected.to respond_with :no_content
        end

        it 'updates character name' do
          expect{ do_request }.to change{ Character.find(character.id).name }
            .from(character.name)
            .to(model_params[:name])
        end
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:character) { create(:character, user: user) }

    context 'when unauthorized user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          delete :destroy, id: character.id
        end
      end
    end

    context 'when authorized user' do
      before do
        log_in user
      end

      context 'when invalid request' do
        it_behaves_like 'bad request' do
          let(:do_request) do
            delete :destroy, id: 123
          end
        end
      end

      context 'when valid request' do
        before do
          delete :destroy, id: character.id
        end

        it { is_expected.to respond_with :no_content }

        it 'deletes character from db' do
          expect( Character.find_by id: character.id ).to eq nil
        end
      end
    end
  end

  describe 'GET show' do
    let!(:character) { create(:character, user: user) }

    context 'when unauthorized user' do
      it_behaves_like 'unauthorized user'do
        let(:do_request) do
          get :show, id: character.id
        end
      end
    end

    context 'when authorized user' do
      before do
        log_in user
      end

      context 'when invalid request' do
        it_behaves_like 'bad request' do
          let(:do_request) do
            get :show, id: 123
          end
        end
      end

      context 'when valid request' do
        before do
          get :show, id: character.id
        end

        it { is_expected.to respond_with :ok }

        it_behaves_like 'respond with character'
      end
    end
  end

  describe 'GET index' do
    context 'when unauthorized user' do
      it_behaves_like 'unauthorized user' do
        let(:do_request) do
          get :index
        end
      end
    end

    context 'when authorized user' do
      before do
        log_in user
      end

      context 'when user have no characters' do
        before do
          get :index
        end

        it { is_expected.to respond_with :ok }

        it 'return empty array' do
          res = { characters: [] }

          expect(json_response).to eq res
        end
      end

      context 'when user have characters' do
        let!(:character_one) { create(:character, user: user) }
        let!(:character_two) { create(:character, user: user) }

        before do
          get :index
        end

        it { is_expected.to respond_with :ok }

        it 'return array with characters' do
          expect(json_response[:characters].length).to eq 2
        end
      end
    end
  end
end
