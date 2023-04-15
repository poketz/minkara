class PostCommentsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]
  
  def create
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.all
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.post_id = params[:post_id]
    if @post_comment.save
      flash.now[:success] = 'コメントを投稿しました'
    end

  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash.now[:secondary] = "コメントを削除しました"
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.all
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
