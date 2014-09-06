require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of :email }
  end
end
