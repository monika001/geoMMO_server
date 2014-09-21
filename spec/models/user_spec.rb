require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  describe 'validations' do
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

  describe '.authenticate' do
    context 'without crednetials' do
      let(:email) { nil }

      it 'returns nil' do
        expect(User.authenticate(email)).to be nil
      end
    end

    context 'with invalid crednetials' do
      let(:email) { '' }

      it 'returns nil' do
        expect(User.authenticate(email)).to be nil
      end
    end

    context 'with valid crednetials' do
      let(:email) { user.email }

      it 'returns user' do
        expect(User.authenticate(email)).to eq user
      end
    end
  end
end
