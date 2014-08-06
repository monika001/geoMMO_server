require 'rails_helper'

RSpec.describe Api::V1::SampleServiceController, :type => :controller do
  describe 'GET sample' do
    it 'should respond with status 200' do
      get :sample
      expect( response.status ).to eq 200
    end
  end
end
