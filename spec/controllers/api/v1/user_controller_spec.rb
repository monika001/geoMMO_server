require 'rails_helper'

describe Api::V1::UsersController do
  describe '#create' do
    bad_request_credentials =
    [
      { e: 'sample@email.com' },
      'sample@email.com',
      nil,
    ]

    bad_request_credentials.each do |credentials|
      context "with #{credentials}" do
        it 'is :bad_request' do
          post :create, format: :json, credentials: credentials

          is_expected.to respond_with(:bad_request)
        end
      end
    end

    unprocessable_credentials =
    [
      { email: nil },
      { email: '' },
      { email: '@email.com' },
      { email: 'sample@com' },
      { email: 'sample@email' },
      { email: 'sampleemail.com' },
      { email: 'sample@' },
    ]

    unprocessable_credentials.each do |credentials|
      context "with #{credentials} " do
        it 'is :unprocessable_entity' do
          post :create, format: :json, credentials: credentials

          is_expected.to respond_with(:unprocessable_entity)
        end
      end
    end

    context 'when email already exists' do
      let(:credentials) do
        { email: 'sample@email.co' }
      end

      before do
        post :create, format: :json, credentials: credentials.downcase
      end

      it 'is :unprocessable_entity' do
        post :create, format: :json, credentials: credentials.upcase

        is_expected.to respond_with(:unprocessable_entity)
      end
    end


    valid_credentials =
    [
      { email: 'sample@sample.co' },
      { email: 'sAmPlE@sAmPle.cO' },
      { email: 'sample@sample.co'.upcase },
    ]

    valid_credentials.each  do |credentials|
      context "with #{credentials}" do
        it 'is :created' do
          post :create, format: :json, credentials: credentials

          is_expected.to respond_with(:created)
        end
      end
    end
  end
end
