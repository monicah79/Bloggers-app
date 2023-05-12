require 'jwt'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_one_attached :photo # Add this line to define the photo attachment
  attribute :posts_counter, :integer, default: 0
  validates :name, :bio, presence: true # Remove :photo from this validation
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  attr_accessor :confirmation_token

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
