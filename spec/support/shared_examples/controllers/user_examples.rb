shared_examples_for 'respond with current user' do
  it 'returns current_user id' do
    expect(json_response[:user][:id]).to eq user.id
  end

  it 'returns current_user email' do
    expect(json_response[:user][:email]).to eq user.email
  end
end
