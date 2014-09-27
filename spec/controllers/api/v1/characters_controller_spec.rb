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
      it_behaves_like 'unauthorized user', :post, :create
    end

    context 'when authorized user' do
      before do
        log_in user
      end

      context 'when unprocessable entity' do
        shared_examples_for 'unprocessable entity' do |model_params|
          context "with params: #{model_params}" do
            before do
              post :create, format: :json, character: model_params
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
        let(:character_params) do
          {
            name: 'Sample'
          }
        end

        before do
          post :create, format: :json, character: character_params
        end

        it { is_expected.to respond_with :created }

        it_behaves_like 'respond with location header'
        it_behaves_like 'respond with character'
      end
    end
  end

  describe 'PUT update'

  describe 'DELETE destroy'

  describe 'GET show'

  describe 'GET index'
end
