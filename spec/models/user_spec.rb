require 'rails_helper'

RSpec.describe User, type: :model do
  it '#is valid with valid attributes' do
    expect(User.new(name: 'John Doe', photo: 'photo.jpg', bio: 'Lorem ipsum', posts_counter: 0)).to be_valid
  end

  it 'is not valid without a name' do
    expect(User.new(name: nil)).to_not be_valid
  end

  it 'is not valid without a photo' do
    expect(User.new(photo: nil)).to_not be_valid
  end

  it 'is not valid without a bio' do
    expect(User.new(bio: nil)).to_not be_valid
  end

  it 'is not valid without a posts_counter' do
    expect(User.new(posts_counter: nil)).to_not be_valid
  end

  it 'is not valid with a non-numeric posts_counter' do
    expect(User.new(posts_counter: 'abc')).to_not be_valid
  end

  it 'has many posts' do
    assc = described_class.reflect_on_association(:posts)
    expect(assc.macro).to eq :has_many
  end
end
