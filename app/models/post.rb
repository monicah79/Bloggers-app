class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  attribute :likes_counter, :integer, default: 0
  attribute :comments_counter, :integer, default: 0

  validates :title, presence: true
  validates :text, presence: true

  def update_likes_counter
    increment!(:likes_counter)
  end

  def update_comments_counter
    increment!(:comments_counter)
  end

  def update_author_posts_counter
    user.increment_counter(:posts_counter, 1)
  end
end
