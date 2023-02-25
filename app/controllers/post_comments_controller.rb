class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.post_id = params[:post_id]
    if @post_comment.save
      flash[:primary] = "コメントを投稿しました"
      render :post_comments
    else
      render 'posts/show'
    end
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash[:primary] = "コメントを削除しました"
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end
end
