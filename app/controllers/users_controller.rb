class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_check, except: [:show, :search]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @active_users = @user.followings
    @passive_users = @user.followers
    @request = Request.new
  end

  def show_info
  end

  def edit
  end

  def update
  end

  def confirm
  end

  def withdraw
  end

  def search
    if params[:word].present?
      @users = User.search(params[:search], params[:word])
      if @users.count != 0
        flash.now[:primary] = "#{@users.count}人のユーザーが見つかりました。"
      else
        flash.now[:danger] = "ユーザーが見つかりませんでした。"
      end
    else
      @users = User.none
    end
  end
end
