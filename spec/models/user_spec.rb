require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of :email }
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
