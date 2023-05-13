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

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_session_path, notice: 'Welcome! You have signed up successfully. Please sign in to continue.'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'Your information has been updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: 'Your account has been successfully deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
