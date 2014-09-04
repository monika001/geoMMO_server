require 'rails_helper'

describe Api::V1::UsersController do
  describe 'POST create' do
    it 'respond with status 200- ok' do
      post :create, format: :json
      expect( response.status ).to eq 200
    end
  end
end
