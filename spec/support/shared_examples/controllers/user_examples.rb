shared_examples_for 'respond with current user' do
  it 'returns current_user id' do
    expect(json_response[:user][:id]).to eq user.id
  end

  it 'returns current_user email' do
    expect(json_response[:user][:email]).to eq user.email
  end

  it 'returns current_user first_name' do
    expect(json_response[:user][:first_name]).to eq user.first_name
  end

  it 'returns current_user last_name' do
    expect(json_response[:user][:last_name]).to eq user.last_name
  end
end
