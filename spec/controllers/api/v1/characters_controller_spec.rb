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
        shared_examples_for 'unprocessable entity' do |model_params|
          context "with params: #{model_params}" do
            before do
              post :create, character: model_params
            end

            it { is_expected.to respond_with :unprocessable_entity }

            it 'respond with errors' do
              expect(json_response[:errors]).not_to be_empty
            end
          end
        end

        it_behaves_like 'unprocessable entity', { name: ' ' }
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

  describe 'DELETE destroy'

  describe 'GET show'

  describe 'GET index'
end
