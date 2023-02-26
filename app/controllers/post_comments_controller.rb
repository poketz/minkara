class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.all
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.post_id = params[:post_id]
    if @post_comment.save
      flash.now[:primary] = 'コメントを投稿しました'
    # else
    #   render 'error'
    end

  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash.now[:primary] = "コメントを削除しました"
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.all
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end
end
