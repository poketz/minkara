class SearchesController < ApplicationController
  def post_search
    @posts = Post.search(params[:word])
  end

  def user_search
  end
end
