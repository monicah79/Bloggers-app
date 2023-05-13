require 'jwt'
class UserController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]

  def index
    @users = User.all
    @current_user = current_user
  end

  def show
    @user = User.find(params[:id])
    @user_posts = Post.where(author_id: @user.id)
    @recent_posts = @user.recent_posts
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
