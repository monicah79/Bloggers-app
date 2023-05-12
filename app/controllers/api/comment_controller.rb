require 'jwt'

class Api::CommentController < ApplicationController
  before_action :set_post, only: %i[show create]
  before_action :set_user, only: %i[show create]

  def index
    @comment = Comment.new
    render json: { comment: @comment }, status: :ok
  end

  def create
    @comment = @user.comments.new(post: @post, **comment_params)
    if @comment.save
      render json: { comment: @comment }, status: :created
    else
      render json: { error: @comment.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
