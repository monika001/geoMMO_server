require 'rails_helper'

describe Session::LogUserIn do
  let!(:user) { create(:user) }

  before do
    user.regenerate_token
  end

  describe '.with_credentials' do
    context 'with invalid credentials' do
      let(:credentials) do
        {
          email: user.email
        }
      end

      it 'returns nil' do
        expect(Session::LogUserIn.with_credentials(credentials)).to eq nil
      end
    end

    context 'with valid credentials' do
      let(:credentials) do
        {
          email: user.email,
          password: user.password
        }
      end

      it 'returns user' do
        expect(Session::LogUserIn.with_credentials(credentials)).to eq [user, User.find(user).token]
      end
    end
  end

  describe '.with_token' do
    context 'with invalid token' do
      let!(:user_with_nil_token) { create(:user, token: nil) }
      let(:token) { nil }

      it 'returns nil' do
        expect(Session::LogUserIn.with_token(token)).to eq nil
      end
    end

    context 'with valid token' do
      it 'returns user' do
        expect(Session::LogUserIn.with_token(user.token)).to eq user
      end
    end
  end
end
