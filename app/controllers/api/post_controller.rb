class Api::PostController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @recent_posts = @user.recent_posts
    @post_comments = Comment.where(post_id: @posts.pluck(:id))
    render json: { data: @posts }, status: :ok
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
    render json: { data: @post, comments: @comments }, status: :ok
  end
end
