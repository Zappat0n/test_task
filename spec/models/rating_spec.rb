require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:user) { User.create(username: 'John', password: 'abcdefg') }

  it 'Happy path' do
    expect(Rating.count).to eq 0
    Rating.create(rating_value: 2, user: user)
    expect(Rating.count).to eq 1
  end

  it 'Does not allow rating value outside 1..5' do
    rating = Rating.new(rating_value: 0, user: user)
    expect(rating.valid?).to be false

    rating = Rating.new(rating_value: 8, user: user)
    expect(rating.valid?).to be false
  end

  it 'Rating value must be integer' do
    rating = Rating.new(rating_value: 2.5, user: user)
    expect(rating.valid?).to be false
  end

  it 'Does not allow empty user' do
    rating = Rating.new(rating_value: 1)
    expect(rating.valid?).to be false
  end
end
