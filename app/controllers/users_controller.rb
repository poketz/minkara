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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user.id), success: "ユーザー情報を変更しました"
    else
       render "edit"
    end
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
  
  private
  
  def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation, 
                                  :gender, :prefecture, :birthday, :profile_image)
  end
end
