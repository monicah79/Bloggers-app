require 'jwt'
class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @current_user = current_user
  end

  def show
    @user = User.find(params[:id])
    @user_posts = Post.where(author_id: @user.id)
    @recent_posts = @user.recent_posts
  end

  def edit
    @user = User.find(params[:id])
  end
end
