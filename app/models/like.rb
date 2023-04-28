class Like < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user
  attribute :user_id, :integer

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
