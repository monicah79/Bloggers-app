class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :title, length: { in: 1..250 }
  validates :text, presence: true
  validates :author_id, presence: true
  validates :likes_counter, :comments_counter, numericality: { greater_than_or_equal_to: 0 }

  # Set default values for likes_counter and comments_counter
  attribute :likes_counter, :integer, default: 0
  attribute :comments_counter, :integer, default: 0

  def update_likes_counter
    increment!(:likes_counter)
  end

  def update_comments_counter
    increment!(:comments_counter)
  end

  def update_author_posts_counter
    author.increment_counter(:posts_counter, 1)
  end
end
