require 'rails_helper'

describe Session::LogUserOut do
  let(:user) { create(:user) }

  before do
    add_user_to_session(user)
  end

  describe '.call' do
    it 'removes user form session' do
      Session::LogUserOut.call(user)

      expect(user.token).to eq nil
    end
  end
end
