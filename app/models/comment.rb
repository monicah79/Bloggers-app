class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :author, class_name: 'User'
  belongs_to :user

  def update_comments_counter
    post.comments_counter += 1
    post.save
  end
end
