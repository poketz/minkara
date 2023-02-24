class PostCommentsController < ApplicationController
  def create
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.save!
  end

  def destroy
  end
  
  private
  
  params.permit(:post_comment).require(:comment)
end
