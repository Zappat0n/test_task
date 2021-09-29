require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Happy path' do
    expect(User.count).to eq 0
    User.create(username: 'John', password: 'abcdefg')
    expect(User.count).to eq 1
  end

  it 'Does not allow empty username' do
    user = User.create(username: '', password: 'abcdefg')
    expect(user.valid?).to be false
  end

  it 'Does not allow blank password' do
    user = User.create(username: 'John', password: '')
    expect(user.valid?).to be false

    user = User.create(username: 'John')
    expect(user.valid?).to be false
  end
end
