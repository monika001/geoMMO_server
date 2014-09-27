shared_examples_for 'unauthorized user' do
  before do
    do_request
  end

  it { is_expected.to respond_with(:unauthorized) }

  it 'returns errors messages' do
    expect(json_response[:errors]).not_to be_empty
  end
end

shared_examples_for 'unprocessable entity' do
  before do
    do_request
  end

  it { is_expected.to respond_with :unprocessable_entity }

  it 'respond with errors' do
    expect(json_response[:errors]).not_to be_empty
  end
end

shared_examples_for 'bad request' do
  before do
    do_request
  end

  it { is_expected.to respond_with :bad_request }

  it 'respond with empty body' do
    expect(response.body.strip).to be_empty
  end
end

shared_examples_for 'respond with location header' do
  describe 'respond with location header' do
    it 'is not nil' do
      expect(response.location).not_to be_empty
    end

    it 'is path, not url' do
      expect(response.location).not_to include('http://')
    end
  end
end
