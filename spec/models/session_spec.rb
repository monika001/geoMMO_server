require "rails_helper"

describe Session do
  subject { Session.instance }

  let(:user) { create(:user) }

  describe ".authenticate_user_with_credentials" do
    context "without credentials" do
      let(:credentials) { nil }

      it "returns nil" do
        expect( subject.authenticate_user_with_credentials credentials ).to eq nil
      end
    end

    context "with invalid crednetials" do
      let(:credentials) do
        { email: '' }
      end

      it 'returns nil' do
        expect( subject.authenticate_user_with_credentials credentials ).to eq nil
      end
    end

    context "with valid credentials" do
      let(:credentials) do
        { email: user.email }
      end

      it 'returns user' do
        expect( subject.authenticate_user_with_credentials credentials ).to eq user
      end

      context "when user already exists" do
        before do
          subject.authenticate_user_with_credentials credentials
        end

        it "returns user" do
          expect( subject.authenticate_user_with_credentials credentials ).to eq user
        end

        it "do NOT add new token" do
          old_length = session_length
          subject.authenticate_user_with_credentials credentials

          expect( session_length ).to eq old_length
        end

        it "changes previous token" do
          old_token = token_of(user)
          subject.authenticate_user_with_credentials credentials

          expect( token_of(user) ).not_to eq old_token
        end
      end
    end
  end

  describe ".authenticate_user_with_token" do
    context "without token" do
      let(:token) { nil }

      it "returns nil" do
        expect( subject.authenticate_user_with_token token ).to eq nil
      end
    end

    context "with invalid token" do
      let(:token) { 'invalid_token' }

      it 'returns nil' do
        expect( subject.authenticate_user_with_token token).to eq nil
      end
    end

    context "with valid token" do
      let(:token) { token_of(user) }
      let(:credentials) do
        { email: user.email }
      end

      before do
        subject.authenticate_user_with_credentials credentials
      end

      it 'returns user' do
        expect( subject.authenticate_user_with_token token ).to eq user
      end
    end
  end

  describe ".regenerate_token" do
    context "when new user" do
      it "returns string token" do
        expect( subject.regenerate_token(user) ).to be_a String
      end

      it "add user to session" do
        old_length = session_length
        subject.regenerate_token(user)

        expect( session_length).to eq old_length + 1
      end
    end

    context "when user already exists" do
      before do
        add_user_to_session user
      end

      it "generates new token" do
        old_token = token_of user
        subject.regenerate_token(user)

        expect( token_of(user) ).not_to eq old_token
      end

      it "does NOT cause redundant of users" do
        old_length = session_length
        subject.regenerate_token(user)

        expect( session_length ).to eq old_length
      end
    end
  end

  describe ".destroy_token" do
    context "with user out of session" do
      it "does nothing" do
        old_length = session_length
        subject.destroy_token(user)

        expect( session_length ).to eq old_length
      end
    end

    context "with user logged in" do
      before do
        add_user_to_session user
      end

      it "removes user" do
        old_length = session_length
        subject.destroy_token(user)

        expect( session_length ).to eq old_length - 1
      end
    end
  end
end
