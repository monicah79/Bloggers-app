class User < ApplicationRecord
  Include default devise modules. Others available are:
  :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, dependent: :destroy, counter_cache: true

  has_one_attached :photo # Add this line to define the photo attachment

  validates :name, :bio, presence: true # Remove :photo from this validation
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  before_save :update_posts_count
  before_create :initialize_posts_count

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  private

  def update_posts_count
    self.posts_count = posts.count
  end

  def initialize_posts_count
    self.posts_count ||= 0
  end
end
