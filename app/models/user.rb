class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', dependent: :destroy

  validates :name, :photo, :bio, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }
  attr_accessor :photo, :bio, :email

  before_save :update_posts_count

  private

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def update_posts_count
    self.posts_count = posts.count
  end
end
