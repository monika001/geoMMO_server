require 'rails_helper'

describe Session::LogUserOut do
  let(:user) { create(:user) }

  before do
    add_user_to_session(user)
  end

  describe '.call' do
    it 'removes user form session' do
      old_length = session_length
      Session::LogUserOut.call(user)

      expect(session_length).to eq old_length - 1
    end
  end
end
