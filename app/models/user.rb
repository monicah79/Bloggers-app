class User < ApplicationRecord
  validates :name, presence: true
  validates :photo, presence: true
  validates :bio, presence: true
  validates :posts_counter, presence: true, numericality: { only_integer: true }
  has_many :comments, foreign_key: :author_id
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: :author_id

  before_save :update_posts_count

  private

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def update_posts_count
    self.posts_count = posts.count
  end
end
