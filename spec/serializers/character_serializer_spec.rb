require 'rails_helper'

describe CharacterSerializer do
  let(:character) { create :character }
  subject { CharacterSerializer.new character }

  context 'when owner? responds with true' do
    before do
      allow(subject).to receive(:owner?).and_return(true)
    end

    it { expect(subject.serializable_hash[:id]).to eq character.id }
    it { expect(subject.serializable_hash[:name]).to eq character.name }
    it { expect(subject.serializable_hash[:experience]).to eq character.experience }
  end

  context 'when owner? responds with false' do
    before do
      allow(subject).to receive(:owner?).and_return(false)
    end

    it { expect(subject.serializable_hash[:id]).to eq character.id }
    it { expect(subject.serializable_hash[:name]).to eq character.name }
    it { expect(subject.serializable_hash[:experience]).to eq nil }
  end
end
