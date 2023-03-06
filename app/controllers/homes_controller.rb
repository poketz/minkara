class HomesController < ApplicationController
  def top
    @posts = Post.order("created_at DESC").limit(20)
    # 週間ランキング
    @week_post_like_ranks = Post.find(Like.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) desc').pluck(:post_id))
  end

  def about
  end
end
