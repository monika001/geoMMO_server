shared_examples_for 'unauthorized user' do |method, action|
  before do
    public_send method, action, { format: :json }
  end

  it { is_expected.to respond_with(:unauthorized) }

  it 'returns errors messages' do
    expect(json_response[:errors]).not_to be_empty
  end
end
