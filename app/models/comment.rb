class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, class_name: 'User'

  def update_comments_counter
    post.update(comments_counter: post.comments_counter + 1)
  end
end
