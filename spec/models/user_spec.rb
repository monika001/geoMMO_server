require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  describe 'validations' do
    describe 'password_confirmation' do
      let(:user) { build(:user) }

      context 'without password' do
        it 'is invalid' do
          user.password = nil
          user.password_confirmation = nil

          expect(user).not_to be_valid
        end
      end

      context 'without password_confirmation' do
        it 'is invalid' do
          user.password = 'password'
          user.password_confirmation = nil

          expect(user).not_to be_valid
        end
      end

      context 'is the same as password' do
        it 'is valid' do
          expect(user).to be_valid
        end
      end

      context 'is NOT the same as password' do
        before do
          user.password += '_mistyped'
        end

        it 'is NOT valid' do
          expect(user).not_to be_valid
        end
      end
    end

    describe 'email' do
      context 'when valid' do
        valid_emails =
        [
          'sample@sample.co',
          'SAMPLE@SAMPLE.co',
          'sample123@sample.co',
        ]

        valid_emails.each do |valid_email|
          context "#{valid_email}" do
            it 'returns true' do
              user = build(:user, email: valid_email)

              expect(user.valid?).to be true
            end
          end
        end
      end

      context 'when invalid' do
        invalid_emails =
        [
          'samplesample.co',
          'sample@sampleco',
          '@sample.co',
          'sample@.co',
          'sample@sample.',
        ]

        invalid_emails.each do |invalid_email|
          context "#{invalid_email}" do
            it 'returns false' do
              user = build(:user, email: invalid_email)

              expect(user.valid?).to be false
            end
          end
        end
      end

      context 'when already exists' do
        let(:email) { 'sample@email.co' }
        let(:user) { build(:user, email: email) }
        let(:duplicated_user) { build(:user, email: email) }

        before do
          user.save
        end

        it 'returns false' do
          expect(duplicated_user.valid?).to eq false
        end
      end
    end
  end

  describe '#authenticate' do
    context 'without crednetials' do
      let(:credentials) do
        { email: nil, password: nil }
      end

      it 'returns nil' do
        expect(user.authenticate credentials[:password]).to be nil
      end
    end

    context 'with invalid crednetials' do
      invalid_credentials =
      [
        { email: '' },
        { email: 'sample@email.com', password: 'superPassword' },
        { email: '', password: '', password_confirmation: '' },
      ]

      invalid_credentials.each do |credentials|
        context "when credentials: #{credentials}" do
          it 'returns nil' do
            expect(user.authenticate credentials[:password]).to be nil
          end
        end
      end
    end

    context 'with valid crednetials' do
      let(:credentials) do
        { email: user.email, password: user.password }
      end

      it 'returns user' do
        expect(user.authenticate credentials[:password]).to eq user
      end
    end
  end

  describe '#regenerate_token' do
    subject { user.regenerate_token }

    it { expect{ subject }.to change(user, :token) }
    it { is_expected.to eq user.token }
  end

  describe '#destroy_token' do
    subject { user.destroy_token }

    it 'sets token to nil' do
      subject
      expect(user.token).to eq nil
    end
  end

  describe '#to_s' do
    let(:user) { build(:user, email: 'los.samplos@sample.co') }
    subject { user.to_s }

    it { is_expected.to eq 'los.samplos@sample.co' }
  end
end
