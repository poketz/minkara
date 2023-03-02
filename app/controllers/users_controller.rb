class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
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
      @users = User.search(params[:word])
    else
      @users = User.none
    end
  end
end
