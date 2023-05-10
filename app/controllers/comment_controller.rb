class CommentController < ApplicationController
  # controller actions and methods
  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    new_comment = current_user.comments.new(post_id: @post.id,
                                            author_id: current_user.id, text: comment_text)
    respond_to do |format|
      format.html do
        if new_comment.save
          redirect_to "/user/#{@post.author_id}/post/#{@post.id}", notice: 'Success Comment Saved!'
        else
          render :new, status: 'Comment error!'
        end
      end
    end
  end

  private

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])

    if @comment&.destroy
      flash[:success] = 'Comment deleted!'
      @comment.post.decrement!(:comments_counter)
    else
      flash[:danger] = 'Comment not deleted!'
    end
    redirect_to user_post_path(current_user.id, @post.id)
  end

  def comment_text
    params.require(:comment).permit(:text)[:text]
  end
end
