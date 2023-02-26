class LikesController < ApplicationController
  def create
    pos = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: pos.id)
    like.save!
    redirect_to post_path(pos)
  end

  def destroy
  end
end
