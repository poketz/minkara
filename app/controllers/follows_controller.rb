class FollowsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    flash[:primary] = "ユーザーをフォローしました。"
    redirect_to user_path(@user.id)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
    flash[:primary] = "ユーザーのフォローを外しました。"
    redirect_to user_path(@user.id)
  end
end
