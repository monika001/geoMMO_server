require 'rails_helper'

describe Api::V1::UsersController do
  describe '#create' do
    before do
      post :create, format: :json
    end

    it { is_expected.to respond_with(:ok) }
  end
end
