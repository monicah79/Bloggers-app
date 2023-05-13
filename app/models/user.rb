require 'jwt'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_one_attached :photo # Add this line to define the photo attachment
  attribute :posts_counter, :integer, default: 0
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }



  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
