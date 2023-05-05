class PostController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.where(author_id: @user.id)
    @user_comments = Comment.where(user_id: @user.id)
    @post_comments = Comment.where(post_id: @user_posts.ids)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find_by(id: params[:id])
    if @post.nil?
      flash[:error] = 'Post not found'
      redirect_to user_post_path(@user)
    else
      @likes = @post.likes # Get all likes for the post
    end
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
    render :new, locals: { post: @post }
  end

  def like
    @post = Post.find(params[:id])
    @like = @post.likes.build(user_id: current_user.id) # Create a new like object for the current user and post

    if @like.save
      flash[:success] = 'You liked this post!'
    else
      flash[:error] = 'There was an error liking this post.'
    end

    redirect_to @post
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to user_post_path(@user, @post)
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path(current_user), notice: 'Post was successfully deleted.'
  end

  private

  def set_post
    return unless params[:id].present? && params[:id] != 'new'
    return unless params[:id].to_i.to_s == params[:id]

    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
