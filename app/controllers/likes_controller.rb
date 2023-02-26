class LikesController < ApplicationController
  def create
    pos = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: pos.id)
    like.save!
    redirect_to post_path(pos)
  end

  def destroy
    pos = Post.find(params[:post_id])
    # urlにIDがないのでpost_idで投稿の取得
    like = current_user.likes.find_by(post_id: pos.id)
    like.destroy
    redirect_to post_path(pos)
  end
end
