require 'rails_helper'

describe User do
  context 'with the duplicated email' do
    let!(:user) { create(:user, email: 'sample@sample.com')  }
    let!(:duplicated_user) { build(:user, email: 'sample@sample.com')  }

    it 'is not valid' do
      expect(duplicated_user.valid?).to eq false
    end
  end

  context 'with the already registered token' do
    let!(:user) { create(:user, token: '1')  }
    let!(:duplicated_user) { build(:user, token: '1')  }

    it 'is not valid' do
      expect(duplicated_user.valid?).to eq false
    end
  end
end
