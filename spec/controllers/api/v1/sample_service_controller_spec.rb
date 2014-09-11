require 'rails_helper'

describe Api::V1::SampleServiceController do
  describe 'GET sample' do
    it 'should respond with status :ok' do
      get :sample, format: :json

      is_expected.to respond_with :ok
    end
  end

  describe 'GET sample_user' do
    it 'should respond with status :ok' do
      get :sample_user, format: :json

      is_expected.to respond_with :ok
    end
  end
end
