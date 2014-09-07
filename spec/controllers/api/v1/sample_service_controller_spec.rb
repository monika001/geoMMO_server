require 'rails_helper'

describe Api::V1::SampleServiceController do
  describe 'GET sample' do
    it 'should respond with status 200' do
      get :sample, format: :json
      expect(response.status).to eq 200
    end
  end
end
