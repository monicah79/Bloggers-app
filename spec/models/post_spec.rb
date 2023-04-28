require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(name: 'John Doe', photo: 'photo.jpg', bio: 'This is my bio', posts_counter: 0)
      post = Post.new(author_id: user.id, title: 'Test post', text: 'This is a test post', comments_counter: 0,
                      likes_counter: 0)
      expect(post).to be_valid
    end

    it 'is not valid without an author_id' do
      post = Post.new(author_id: nil, title: 'Test post', text: 'This is a test post', comments_counter: 0,
                      likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid without a title' do
      post = Post.new(author_id: 1, title: nil, text: 'This is a test post', comments_counter: 0, likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid without text' do
      post = Post.new(author_id: 1, title: 'Test post', text: nil, comments_counter: 0, likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid without a comments_counter' do
      post = Post.new(author_id: 1, title: 'Test post', text: 'This is a test post', comments_counter: nil,
                      likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid without a likes_counter' do
      post = Post.new(author_id: 1, title: 'Test post', text: 'This is a test post', comments_counter: 0,
                      likes_counter: nil)
      expect(post).to_not be_valid
    end

    it 'is not valid with a non-numeric comments_counter' do
      post = Post.new(author_id: 1, title: 'Test post', text: 'This is a test post', comments_counter: 'abc',
                      likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid with a non-numeric likes_counter' do
      post = Post.new(author_id: 1, title: 'Test post', text: 'This is a test post', comments_counter: 0,
                      likes_counter: 'abc')
      expect(post).to_not be_valid
    end
  end
end
