require 'rails_helper'

describe Session::LogUserIn do
  let(:user) { create(:user) }

  before do
    add_user_to_session(user)
  end

  describe '.with_credentials' do
    context 'with invalid credentials' do
      let(:credentials) { nil }

      it 'returns nil' do
        expect(Session::LogUserIn.with_credentials(credentials)).to eq nil
      end
    end

    context 'with valid credentials' do
      let(:credentials) do
        { email: user.email }
      end

      it 'returns user' do
        expect(Session::LogUserIn.with_credentials(credentials)).to eq [user, token_of(user)]
      end
    end
  end

  describe '.with_token' do
    context 'with invalid token' do
      let(:token) { nil }

      it 'returns nil' do
        expect(Session::LogUserIn.with_token(token)).to eq nil
      end
    end

    context 'with valid token' do
      let(:token) { token_of user }

      it 'returns user' do
        expect(Session::LogUserIn.with_token(token)).to eq user
      end
    end
  end
end
