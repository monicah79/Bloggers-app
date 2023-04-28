class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :author, class_name: 'User'
  belongs_to :user

  def update_comments_counter
    post.comments_counter += 1
    post.save
  end

  def create_post
    post = author.posts.create(title: 'Hello', text: 'This is my first post', likes_counter: 5, comments_counter: 5)
    self.post = post
    save
  end
end
