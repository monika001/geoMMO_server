require 'rails_helper'

describe ErrorsController do
  describe 'GET not_found' do
    before do
      get :not_found
    end

    it { is_expected.to respond_with :not_found }
  end

  describe 'GET exception' do
    before do
      get :exception
    end

    it { is_expected.to respond_with :internal_server_error }
  end
end
