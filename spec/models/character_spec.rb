require 'rails_helper'

describe Character do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }

  context 'after creation' do
    let(:character) { create :character }

    it { expect(character.location).not_to eq nil }
  end
end
