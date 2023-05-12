require 'jwt'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, dependent: :destroy, counter_cache: true

  has_one_attached :photo # Add this line to define the photo attachment

  validates :name, :bio, presence: true # Remove :photo from this validation
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }
  before_save :update_posts_count
  before_create :initialize_posts_count

  attr_accessor :confirmation_token
  attr_accessor :email, :password, :unconfirmed_email



  def generate_jwt
    payload = { user_id: id }
    secret_key = Rails.application.secrets.jwt_secret_key
    algorithm = 'HS256'
    JWT.encode(payload, secret_key, algorithm)
  end

  def self.decode_jwt(token)
    decoded_token = JWT.decode(token, Rails.application.secrets.jwt_secret_key, true, { algorithm: 'HS256' })
    payload = decoded_token.first
    User.find(payload['user_id'])
  end

  def self.generate_jwt
    # implementation
  end

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
