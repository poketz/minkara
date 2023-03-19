class HomesController < ApplicationController
  def top
    @posts = Post.order("created_at DESC").limit(20)
    # 週間ランキング
    @week_post_like_ranks = Post.where(created_at: Time.current.all_week).sort { |a, b| b.likes.count <=> a.likes.count }
  end

  def about
  end
end
