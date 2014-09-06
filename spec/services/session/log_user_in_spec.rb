require 'rails_helper'

describe Session::LogUserIn do
  let(:user) { create(:user) }

  describe ".with_credentials" do
    context "with invalid credentials" do
      let(:credentials) { nil }

      it "returns nil" do
        expect( Session::LogUserIn.with_credentials(credentials) ).to eq nil
      end
    end

    context "with valid credentials" do
      let(:credentials) do
        { email: user.email }
      end

      it "returns user" do
        expect( Session::LogUserIn.with_credentials(credentials) ).to eq user
      end
    end
  end

  describe ".with_token" do
    before do
      add_user_to_session user
    end

    context "with invalid token" do
      let(:token) { nil }

      it "returns nil" do
        expect( Session::LogUserIn.with_token(token) ).to eq nil
      end
    end

    context "with valid token" do
      let(:token) { token_of user }

      it "returns user" do
        expect( Session::LogUserIn.with_token(token) ).to eq user
      end
    end
  end
end
