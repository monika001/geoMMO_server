require 'rails_helper'

describe Session::LogUserOut do
  let(:user) { create(:user) }

  before do
    user.regenerate_token
  end

  describe '.call' do
    it 'removes user form session' do
      Session::LogUserOut.call(user)

      expect(user.token).to eq nil
    end
  end
end
